import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { InjectRepository, InjectDataSource } from '@nestjs/typeorm';
import { Repository, DataSource } from 'typeorm';
import { ConfigService } from '@nestjs/config';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';
import { CreateWatchlistDto } from './dto/create-watchlist.dto';
import { Watchlist } from './entities/WatchList.entity';
import { MarketCloseReport, ReportItem } from './entities/MarketCloseReport.entity';
import { validate } from 'class-validator';
import { plainToInstance } from 'class-transformer';
import axios from 'axios';
 
const RSI_PERIOD = 14; // จำนวนวันมาตรฐานที่ใช้คำนวณ RSI
const HISTORY_BUFFER_DAYS = 10; // ดึงข้อมูลย้อนหลังเผื่อเพิ่ม กันกรณีวันหยุด/ข้อมูลขาดบางวัน
 
// โครงสร้างข้อมูลราคาต่อวัน ใช้เป็นรูปแบบกลางไม่ว่าจะมาจาก DB หรือจาก API ภายนอก
interface PricePoint {
  date: string;
  close: number;
  volume: number;
}
 
// แถวที่ได้จากตาราง price_alert_stocks
interface PriceRow {
  price_date: string | Date;
  eod_price: string | number | null;
  volume: string | number | null;
}
 
// โครงสร้างข้อมูลแท่งราคาจาก Massive API
interface MassiveBar {
  t: number;
  c?: number | null;
  v?: number | null;
}
 
interface MassiveAggsResponse {
  results?: MassiveBar[];
  error?: string;
}
 
type MetricGroups = Record<'price' | 'volume' | 'RSI', Record<string, unknown>>;
 
@Injectable()
export class WatchlistService {
  constructor(
    @InjectRepository(Watchlist)
    private readonly watchlistRepository: Repository<Watchlist>,
    @InjectRepository(MarketCloseReport)
    private readonly reportRepository: Repository<MarketCloseReport>,
    @InjectDataSource()
    private readonly dataSource: DataSource,
    private readonly configService: ConfigService,
    private readonly httpService: HttpService,
  ) {}
 
  //บันทึก watchlist ลงดาต้าเบส
  async saveWatchlist(dto: CreateWatchlistDto) {
    const dtoInstance = plainToInstance(CreateWatchlistDto, dto);
    const errors = await validate(dtoInstance);
 
    if (errors.length > 0) {
      const errorMessages = errors
        .map((err) => Object.values(err.constraints || {}).join(', '))
        .join('; ');
 
      throw new HttpException(
        {
          status: 'error',
          message: `Validation failed: ${errorMessages}`,
        },
        HttpStatus.BAD_REQUEST,
      );
    }
 
    const existing = await this.watchlistRepository.findOne({
      where: { user_id: dto.user_id },
    });
 
    if (existing) {
      existing.symbols = dto.symbols;
      existing.comparison_period = dto.comparison_period;
      existing.report_fields = dto.report_fields;
 
      const updatedData = await this.watchlistRepository.save(existing);
 
      return {
        status: 'success',
        message: 'Watchlist updated successfully',
        data: {
          id: updatedData.id,
          user_id: updatedData.user_id,
          symbols: updatedData.symbols,
          comparison_period: updatedData.comparison_period,
          report_fields: updatedData.report_fields,
          updated_at: updatedData.updated_at,
        },
      };
    }
 
    const newWatchlist = this.watchlistRepository.create(dto);
    const savedData = await this.watchlistRepository.save(newWatchlist);
 
    return {
      status: 'success',
      message: 'Watchlist saved successfully to PostgreSQL database',
      data: {
        id: savedData.id,
        user_id: savedData.user_id,
        symbols: savedData.symbols,
        comparison_period: savedData.comparison_period,
        report_fields: savedData.report_fields,
        created_at: savedData.created_at,
      },
    };
  }
 
  // แปลงค่า comparison_period ("1DAY"/"3DAY"/"7DAY") ให้เหลือแค่ตัวเลขจำนวนวัน
  private parseComparisonDays(period: string): number {
    const match = /\d+/.exec(period);
    return match ? Number.parseInt(match[0], 10) : 1;
  }
 
  // แปลง Date object ให้เป็น string รูปแบบ YYYY-MM-DD
  private toDateString(date: Date): string {
    return date.toISOString().split('T')[0];
  }
 
  // สร้างรายการวันทำการ(จันทร์-ศุกร์) รายการวันที่ควรจะมีข้อมูลเพื่อเช็คว่ามีวันไหนขาดหายไปจาก DB บ้าง
  private getWeekdaysInRange(from: string, to: string): string[] {
    const dates: string[] = [];
    const cursor = new Date(from);
    const end = new Date(to);
    while (cursor <= end) {
      const day = cursor.getDay();
      if (day !== 0 && day !== 6) {
        dates.push(this.toDateString(new Date(cursor)));
      }
      cursor.setDate(cursor.getDate() + 1);
    }
    return dates;
  }
 
  //วันที่ต้องใช้คือวันไหน แล้วค่อยไปค้นหาด้วย key
  private getTargetPastDate(latestDate: string, comparisonDays: number): string {
    const cursor = new Date(latestDate);
    let counted = 0;
    while (counted < comparisonDays) {
      cursor.setDate(cursor.getDate() - 1);
      const day = cursor.getDay();
      if (day !== 0 && day !== 6) counted++;
    }
    return this.toDateString(cursor);
  }
 
  //คำนวณค่า RSI จากราคาปิดย้อนหลัง
  private calculateRSISeries(closePrices: number[], period = RSI_PERIOD): (number | null)[] {
    if (closePrices.length <= period) return new Array(closePrices.length).fill(null);
 
    const rsiArray: (number | null)[] = new Array(period).fill(null);
    let gains = 0;
    let losses = 0;
    for (let i = 1; i <= period; i++) {
      const change = closePrices[i] - closePrices[i - 1];
      if (change >= 0) gains += change;
      else losses += Math.abs(change);
    }
    let avgGain = gains / period;
    let avgLoss = losses / period;
    let rs = avgLoss === 0 ? 100 : avgGain / avgLoss;
    rsiArray.push(Number((avgLoss === 0 ? 100 : 100 - 100 / (1 + rs)).toFixed(2)));
 
    for (let i = period + 1; i < closePrices.length; i++) {
      const change = closePrices[i] - closePrices[i - 1];
      avgGain = (avgGain * (period - 1) + Math.max(change, 0)) / period;
      avgLoss = (avgLoss * (period - 1) + Math.max(-change, 0)) / period;
      rs = avgLoss === 0 ? 100 : avgGain / avgLoss;
      rsiArray.push(Number((avgLoss === 0 ? 100 : 100 - 100 / (1 + rs)).toFixed(2)));
    }
    return rsiArray;
  }
 
  //อ่านข้อมูลราคาจากตารางกลาง price_alert_stocks โดยกรอง eod_price IS NOT NULL ออก เพื่อไม่ให้แถวที่ sync ไม่สำเร็จหลุดเข้าไปคำนวณ
  private async readFromSharedTable(symbol: string, from: string, to: string): Promise<PricePoint[]> {
    const rows: PriceRow[] = await this.dataSource.query(
      `SELECT price_date, eod_price, volume FROM price_alert_stocks WHERE symbol = $1 AND price_date >= $2 AND price_date <= $3 AND eod_price IS NOT NULL ORDER BY price_date ASC;`,
      [symbol, from, to],
    );
    return rows.map((r) => ({
      date: this.toDateString(new Date(r.price_date)),
      close: Number(r.eod_price),
      volume: r.volume !== null ? Number(r.volume) : 0,
    }));
  }
 
  // ดึงข้อความ error จากหลายรูปแบบ (axios / Error / อื่นๆ) ให้เหลือ string เดียว
  private extractErrorDetail(error: unknown): string {
    if (axios.isAxiosError<{ error?: string }>(error)) {
      return error.response?.data?.error ?? error.message;
    }
    if (error instanceof Error) return error.message;
    return String(error);
  }
 
  //ขอข้อมูลราคาจาก Massive API มาใช้เฉพาะตอนข้อมูลใน DB ไม่ครบ
  private async fetchFromMassiveApi(symbol: string, from: string, to: string): Promise<PricePoint[]> {
    const apiKey = this.configService.get<string>('MASSIVE_API_KEY');
    if (!apiKey) {
      throw new HttpException(
        { status: 'error', message: 'MASSIVE_API_KEY ไม่ได้ถูกตั้งค่าในระบบ' },
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
    const baseUrl =
      this.configService.get<string>('MASSIVE_API_BASE_URL') ?? 'https://api.massive.com';
    const url = `${baseUrl}/v2/aggs/ticker/${symbol}/range/1/day/${from}/${to}?adjusted=true&sort=asc&apiKey=${apiKey}`;
 
    try {
      const response = await firstValueFrom(
        this.httpService.get<MassiveAggsResponse>(url),
      );
      const results = response.data?.results ?? [];
      return results
        .filter((bar) => bar.c !== null && bar.c !== undefined)
        .map((bar) => ({
          date: this.toDateString(new Date(bar.t)),
          close: bar.c as number,
          volume: Math.round(bar.v ?? 0),
        }));
    } catch (error) {
      const detail = this.extractErrorDetail(error);
      throw new HttpException(
        {
          status: 'error',
          message: `ไม่สามารถดึงข้อมูลหุ้น ${symbol} จาก Massive API ได้: ${detail}`,
        },
        HttpStatus.BAD_GATEWAY,
      );
    }
  }
 
  //รวมข้อมูลราคาของ 1 symbol ให้ครบพอสำหรับคำนวณ โดยเช็คทีละวันทำการ ถ้าขาดให้ไปเรียก Massive API มาเติม
  private async getPriceSeries(symbol: string, comparisonDays: number): Promise<PricePoint[]> {
    const today = new Date();
    const windowStart = new Date();
    windowStart.setDate(today.getDate() - (comparisonDays + RSI_PERIOD + HISTORY_BUFFER_DAYS));
    const from = this.toDateString(windowStart);
    const to = this.toDateString(today);
 
    const dbPoints = await this.readFromSharedTable(symbol, from, to);
    const seriesMap = new Map<string, PricePoint>(dbPoints.map((p) => [p.date, p]));
 
    const expectedWeekdays = this.getWeekdaysInRange(from, to);
    const missingDates = expectedWeekdays.filter((d) => !seriesMap.has(d));
 
    if (missingDates.length > 0) {
      const apiPoints = await this.fetchFromMassiveApi(symbol, from, to);
      for (const p of apiPoints) {
        if (!seriesMap.has(p.date)) seriesMap.set(p.date, p);
      }
    }
 
    return Array.from(seriesMap.values()).sort((a, b) => (a.date < b.date ? -1 : 1));
  }
 
  //กรองผลลัพธ์ที่คำนวณแล้ว ให้เหลือเฉพาะ field ที่ user เลือกไว้ตอนสร้าง Watchlist
  private selectReportFields(
    reportFields: string[],
    allGroups: MetricGroups,
  ): Record<string, unknown> {
    let selected: Record<string, unknown> = {};
    for (const field of reportFields) {
      if (field === 'price' || field === 'volume' || field === 'RSI') {
        selected = { ...selected, ...allGroups[field] };
      }
    }
    return selected;
  }
 
  // คำนวณเปอร์เซ็นต์การเปลี่ยนแปลง คืน null ถ้าค่าเดิมเป็น 0/null (หารไม่ได้)
  private percentChange(latest: number, past: number | null): number | null {
    if (!past) return null;
    return ((latest - past) / past) * 100;
  }
 
  // จัดรูปแบบเปอร์เซ็นต์ เช่น "+1.23%" / "-0.50%" คืน null ถ้าไม่มีค่า
  private formatPercent(value: number | null): string | null {
    if (value === null) return null;
    return `${value > 0 ? '+' : ''}${value.toFixed(2)}%`;
  }
 
  // สร้างกลุ่มตัวชี้วัด price / volume / RSI ของวันล่าสุดเทียบกับวันอ้างอิง
  private buildMetricGroups(
    latest: PricePoint,
    past: PricePoint,
    latestRSI: number | null,
    pastRSI: number | null,
  ): MetricGroups {
    const priceChange = this.percentChange(latest.close, past.close) ?? 0;
    const volumeChange = this.percentChange(latest.volume, past.volume) ?? 0;
    const rsiChange = latestRSI === null ? null : this.percentChange(latestRSI, pastRSI);
 
    return {
      price: {
        price: Number(latest.close.toFixed(2)),
        price_change_percent: this.formatPercent(priceChange),
      },
      volume: {
        volume: latest.volume,
        volume_change_percent: this.formatPercent(volumeChange),
      },
      RSI: {
        RSI: latestRSI,
        RSI_change_percent: this.formatPercent(rsiChange),
      },
    };
  }
 
  // สร้างรายงานของหุ้น 1 ตัว (คืน error ใน item ถ้าข้อมูลไม่พอ)
  private async buildSymbolReport(
    symbol: string,
    comparisonDays: number,
    watchlist: Watchlist,
  ): Promise<ReportItem> {
    const records = await this.getPriceSeries(symbol, comparisonDays);
 
    if (records.length < comparisonDays + 1) {
      return {
        symbol,
        error: 'ไม่มีข้อมูลย้อนหลังเพียงพอสำหรับคำนวณ แม้ดึงเพิ่มจาก Massive API แล้ว',
      };
    }
 
    const rsiSeries = this.calculateRSISeries(records.map((r) => r.close));
    const latestIndex = records.length - 1;
    const latest = records[latestIndex];
 
    // หาวันที่เป้าหมายจริง แล้วค้นหาด้วยวันที่ตรงๆ แทนการนับตำแหน่ง array
    const targetPastDate = this.getTargetPastDate(latest.date, comparisonDays);
    const pastIndex = records.findIndex((r) => r.date === targetPastDate);
 
    // หาวันที่เป้าหมายไม่เจอเลยและขอ Massive API แล้วก็ไม่ได้ข้อมูลตอบกลับเป็น error
    if (pastIndex === -1) {
      return {
        symbol,
        error: `ไม่มีข้อมูลราคาของวันที่ ${targetPastDate} ในระบบ แม้ขอเพิ่มจาก Massive API แล้ว ไม่สามารถคำนวณเปรียบเทียบ ${comparisonDays} วันได้`,
      };
    }
 
    const allGroups = this.buildMetricGroups(
      latest,
      records[pastIndex],
      rsiSeries[latestIndex],
      rsiSeries[pastIndex],
    );
 
    return {
      symbol,
      comparison_period: watchlist.comparison_period,
      ...this.selectReportFields(watchlist.report_fields, allGroups),
    };
  }
 
  //ประมวลผลรายงานหลังตลาดปิดของ user
  async processMarketClose(userId: string) {
    const watchlist = await this.watchlistRepository.findOne({ where: { user_id: userId } });
    if (!watchlist) {
      throw new HttpException(
        {
          status: 'error',
          message: 'มีข้อมูล Watchlist หรือไม่: ไม่พบข้อมูลผู้ใช้ในระบบ',
        },
        HttpStatus.NOT_FOUND,
      );
    }
 
    const comparisonDays = this.parseComparisonDays(watchlist.comparison_period);
 
    const reportData = await Promise.all(
      watchlist.symbols.map((symbol) =>
        this.buildSymbolReport(symbol, comparisonDays, watchlist),
      ),
    );
 
    const newReport = this.reportRepository.create({
      user_id: userId,
      watchlist_id: watchlist.id,
      data: reportData,
    });
    const savedReport = await this.reportRepository.save(newReport);
 
    return {
      status: 'success',
      report: {
        report_id: savedReport.id,
        user_id: savedReport.user_id,
        data: savedReport.data,
      },
    };
  }
}