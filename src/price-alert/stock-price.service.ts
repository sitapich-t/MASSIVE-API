import { Injectable, Logger, OnModuleInit } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, DataSource } from 'typeorm';
import { firstValueFrom } from 'rxjs';
import { Cron } from '@nestjs/schedule';
import { Stock } from './entities/stock.entity';
import { PriceAlert } from './entities/price.alert';
import { CreatePriceAlertDto } from './dto/price-alert.dto';

export interface EodPriceData {
  price: number;
  open?: number | null;
  high?: number | null;
  low?: number | null;
  volume?: number | null;
  marketCap?: number | null;
  priceDate: string;
}

interface StockInfo {
  symbol: string;
  name: string;
  industry: string;
}

@Injectable()
export class StockPriceService implements OnModuleInit {
  private readonly logger = new Logger(StockPriceService.name);

  // ดึง API Key จากไฟล์ .env
  private readonly API_KEY = process.env.MASSIVE_API_KEY;

  // กัน cron กับการเรียกมือจาก controller รันซ้อนกัน
  private isUpdating = false;

  private readonly initialStocks: StockInfo[] = [
    { symbol: 'MSFT', name: 'Microsoft', industry: 'Technology' },
    { symbol: 'NVDA', name: 'NVIDIA', industry: 'Technology' },
    { symbol: 'LLY', name: 'Eli Lilly', industry: 'Healthcare' },
    { symbol: 'JNJ', name: 'Johnson & Johnson', industry: 'Healthcare' },
    { symbol: 'JPM', name: 'JPMorgan Chase', industry: 'Financials' },
    { symbol: 'V', name: 'Visa', industry: 'Financials' },
    { symbol: 'AMZN', name: 'Amazon', industry: 'Consumer Discretionary' },
    { symbol: 'DIS', name: 'The Walt Disney Company', industry: 'Consumer Discretionary' },
    { symbol: 'XOM', name: 'Exxon Mobil', industry: 'Energy' },
    { symbol: 'CVX', name: 'Chevron', industry: 'Energy' },
  ];

  constructor(
    private readonly httpService: HttpService,
    private readonly dataSource: DataSource,
    @InjectRepository(Stock)
    private readonly stockRepository: Repository<Stock>,
    @InjectRepository(PriceAlert)
    private readonly priceAlertRepository: Repository<PriceAlert>,
  ) {}

  async onModuleInit() {
    this.logger.log('🚀 StockPriceService initialized.');
    if (!this.API_KEY) {
      this.logger.error('❌ MASSIVE_API_KEY is not defined in .env file!');
    }
    await this.fixDatabaseSequences();
  }

  /**
   * ดึง sequence ทั้งหมดที่เกี่ยวข้องกับตารางที่ระบุเพื่อลด Cognitive Complexity
   */
  private async getDatabaseSequencesForTable(table: string): Promise<Set<string>> {
    const seqs = new Set<string>();

    // 1) sequence จาก column default (ตัวที่ใช้จริงตอน INSERT)
    const def = await this.dataSource.query(
      `SELECT column_default FROM information_schema.columns
       WHERE table_schema = 'public' AND table_name = $1 AND column_name = 'id'`,
      [table],
    );
    const match = /nextval\('(.+?)'::regclass\)/.exec(def[0]?.column_default ?? '');
    if (match) seqs.add(match[1]);

    // 2) sequence ที่ผูก OWNED BY / identity
    const owned = await this.dataSource.query(
      `SELECT pg_get_serial_sequence('public.${table}', 'id') AS seq`,
    );
    if (owned[0]?.seq) seqs.add(owned[0].seq);

    // 3) sequence ตกค้างที่ชื่อคล้ายกัน (ใช้ String.raw เพื่อเลี่ยง escaping backslash)
    const similarPattern = String.raw`${table}\_id\_seq%`;
    const similar = await this.dataSource.query(
      `SELECT quote_ident(n.nspname) || '.' || quote_ident(c.relname) AS seq
       FROM pg_class c
       JOIN pg_namespace n ON n.oid = c.relnamespace
       WHERE c.relkind = 'S' AND n.nspname = 'public'
         AND c.relname LIKE $1`,
      [similarPattern],
    );
    for (const row of similar) seqs.add(row.seq);

    return seqs;
  }

  /**
   * ซ่อมแซม Primary Key Sequence ให้ตรงกับ MAX(id)
   */
  private async fixDatabaseSequences() {
    const tables = ['price_alert_stocks', 'user_price_alerts'];

    for (const table of tables) {
      try {
        const seqs = await this.getDatabaseSequencesForTable(table);

        if (seqs.size === 0) {
          this.logger.error(
            `❌ ${table}.id ไม่มี sequence/default ผูกอยู่ ซ่อมไม่ได้ ต้องแก้ schema (ดู SQL ที่แนะนำ)`,
          );
          continue;
        }

        for (const seq of seqs) {
          await this.dataSource.query(
            `SELECT setval($1::regclass, COALESCE((SELECT MAX(id) FROM public."${table}"), 0) + 1, false)`,
            [seq],
          );
          this.logger.log(`✅ Sequence synchronized: ${table} (${seq})`);
        }
      } catch (err) {
        this.logger.error(`❌ Sequence sync failed for ${table}: ${(err as Error).message}`);
      }
    }
  }

  private delay(ms: number) {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }

  /**
   * คำนวณวันที่ย้อนหลัง 1 วัน (YYYY-MM-DD)
   */
  private getYesterdayDateString(): string {
    const date = new Date();
    date.setDate(date.getDate() - 1);
    return date.toISOString().split('T')[0];
  }

  /**
   * บันทึกราคาแบบ UPSERT (INSERT ... ON CONFLICT (symbol, price_date) DO UPDATE)
   */
  private async saveStockPrice(
    stockInfo: StockInfo,
    data: EodPriceData,
    targetDate: string,
  ): Promise<Stock | null> {
    try {
      return await this.saveStockPriceOnce(stockInfo, data, targetDate);
    } catch (err) {
      const driverError = (err as { driverError?: { code?: string; constraint?: string } })
        .driverError;
      const isPkCollision =
        driverError?.code === '23505' && (driverError.constraint ?? '').startsWith('PK_');

      if (!isPkCollision) throw err;

      // PK ชน = sequence ตามหลัง MAX(id) ซ่อมแล้วลองใหม่ 1 ครั้ง
      this.logger.warn(`⚠️ PK collision on ${stockInfo.symbol}, resyncing sequence and retrying...`);
      await this.fixDatabaseSequences();
      return await this.saveStockPriceOnce(stockInfo, data, targetDate);
    }
  }

  private async saveStockPriceOnce(
    stockInfo: StockInfo,
    data: EodPriceData,
    targetDate: string,
  ): Promise<Stock | null> {
    const now = new Date();

    await this.stockRepository
      .createQueryBuilder()
      .insert()
      .into(Stock)
      .values({
        symbol: stockInfo.symbol,
        name: stockInfo.name,
        industry: stockInfo.industry,
        eod_price: data.price,
        open: data.open ?? data.price,
        high: data.high ?? data.price,
        low: data.low ?? data.price,
        volume: data.volume ?? 0,
        market_cap: data.marketCap ?? 0,
        price_date: targetDate,
        created_at: now,
        updated_at: now,
      })
      .orUpdate(
        [
          'name',
          'industry',
          'eod_price',
          'open',
          'high',
          'low',
          'volume',
          'market_cap',
          'updated_at',
        ],
        ['symbol', 'price_date'],
      )
      .execute();

    return this.stockRepository
      .createQueryBuilder('stock')
      .where('stock.symbol = :symbol', { symbol: stockInfo.symbol })
      .andWhere('stock.price_date = :priceDate', { priceDate: targetDate })
      .getOne();
  }

  /**
   * ตรวจสอบราคาหุ้นเป้าหมาย
   * หากยังไม่มีใน DB จะยิงดึงราคาจาก API และ UPSERT ลงตารางให้อัตโนมัติ
   */
  async createPriceAlert(dto: CreatePriceAlertDto) {
    const dtoRecord = dto as unknown as Record<string, unknown>;
    const rawTargetPrice = dto.target_price ?? dtoRecord.targetPrice ?? dtoRecord['target price'];
    const { symbol, user_id } = dto;

    if (!symbol) {
      return {
        user_id,
        symbol: null,
        is_triggered: false,
        message: 'กรุณาระบุ symbol ของหุ้น',
      };
    }

    const targetPriceNum = Number(rawTargetPrice);
    const cleanSymbol = symbol.trim().toUpperCase();

    // 1. ลองค้นหาข้อมูลราคาล่าสุดใน DB เพื่อเช็คเบื้องต้น
    let latestStock = await this.stockRepository
      .createQueryBuilder('stock')
      .where('UPPER(TRIM(stock.symbol)) = :symbol', { symbol: cleanSymbol })
      .orderBy('stock.price_date', 'DESC')
      .getOne();

    // 2. ถ้าใน DB ยังไม่มีข้อมูล หรือ eod_price เป็น null ให้ดึงจาก API
    if (latestStock?.eod_price == null) {
      this.logger.log(`🔍 ไม่พบข้อมูลราคา ${cleanSymbol} ใน DB กำลังดึงราคาจาก API...`);

      const apiData = await this.fetchEodPriceFromMassive(cleanSymbol);

      if (apiData?.price != null) {
        const stockInfo: StockInfo = this.initialStocks.find((s) => s.symbol === cleanSymbol) ?? {
          symbol: cleanSymbol,
          name: cleanSymbol,
          industry: 'N/A',
        };
        const targetDate = apiData.priceDate || this.getYesterdayDateString();

        try {
          const saved = await this.saveStockPrice(stockInfo, apiData, targetDate);
          if (saved) {
            latestStock = saved;
            this.logger.log(
              `✅ [SAVE SUCCESS] บันทึกข้อมูลราคา ${cleanSymbol} ($${saved.eod_price}) วันที่ ${targetDate} ลง DB สำเร็จ!`,
            );
          }
        } catch (err) {
          this.logger.error(`[SAVE ERROR] ${cleanSymbol}: ${(err as Error).message}`);
        }
      }
    }

    if (latestStock?.eod_price == null) {
      return {
        user_id,
        symbol: cleanSymbol,
        target_price: targetPriceNum,
        is_triggered: false,
        message: `ไม่พบข้อมูลราคาหุ้น ${cleanSymbol}`,
      };
    }

    const currentPrice = Number(latestStock.eod_price);
    const isTriggered = currentPrice >= targetPriceNum;

    if (isTriggered) {
      this.logger.warn(
        `🔔 [INSTANT ALERT] หุ้น ${cleanSymbol}: ราคาปัจจุบัน ($${currentPrice}) แตะหรือเกินเป้าหมาย ($${targetPriceNum}) แล้ว!`,
      );
    }

    return {
      user_id,
      symbol: cleanSymbol,
      current_price: currentPrice,
      target_price: targetPriceNum,
      price_date: latestStock.price_date,
      is_triggered: isTriggered,
      message: isTriggered
        ? `🚨 แจ้งเตือน! ราคาหุ้น ${cleanSymbol} ($${currentPrice}) แตะหรือสูงกว่าเป้าหมาย ($${targetPriceNum}) แล้ว`
        : `ℹ️ ราคาหุ้น ${cleanSymbol} ($${currentPrice}) ยังไม่ถึงเป้าหมาย ($${targetPriceNum})`,
    };
  }

  async getAllAlerts() {
    return await this.priceAlertRepository.find();
  }

  /**
   * ดึงราคาปิด EOD และ Market Cap จาก API โดยตรง
   */
  async fetchEodPriceFromMassive(symbol: string): Promise<EodPriceData | null> {
    try {
      if (!this.API_KEY) {
        throw new Error('API Key is missing');
      }

      const upperSymbol = symbol.toUpperCase();
      const priceUrl = `https://api.massive.com/v2/aggs/ticker/${upperSymbol}/prev?adjusted=true&apiKey=${this.API_KEY}`;
      const detailsUrl = `https://api.massive.com/v3/reference/tickers/${upperSymbol}?apiKey=${this.API_KEY}`;

      const [priceResponse, detailsResponse] = await Promise.all([
        firstValueFrom(
          this.httpService.get(priceUrl, {
            headers: { 'User-Agent': 'Mozilla/5.0' },
          }),
        ),
        firstValueFrom(
          this.httpService.get(detailsUrl, {
            headers: { 'User-Agent': 'Mozilla/5.0' },
          }),
        ).catch(() => null),
      ]);

      const results = priceResponse.data?.results;
      const marketCapRaw = detailsResponse?.data?.results?.market_cap;
      const marketCap = marketCapRaw != null ? Number(marketCapRaw) : null;

      if (results && results.length > 0) {
        const item = results[0];
        const dateStr = item?.t
          ? new Date(item.t).toISOString().split('T')[0]
          : this.getYesterdayDateString();

        return {
          price: Number(item?.c),
          open: item?.o != null ? Number(item.o) : null,
          high: item?.h != null ? Number(item.h) : null,
          low: item?.l != null ? Number(item.l) : null,
          volume: item?.v != null ? Number(item.v) : null,
          marketCap,
          priceDate: dateStr,
        };
      }
      return null;
    } catch (error) {
      const err = error as { response?: { data?: { error?: string } }; message?: string };
      const errDetail = err?.response?.data?.error || err?.message;
      this.logger.error(`Error fetching real price for ${symbol}: ${errDetail}`);
      return null;
    }
  }

  @Cron('0 0 4 * * *', { timeZone: 'Asia/Bangkok' })
  async updateAllStockPrices() {
    if (this.isUpdating) {
      this.logger.warn('⚠️ Update is already running, skipped.');
      return { message: 'Update is already running', updated_stocks: 0 };
    }
    this.isUpdating = true;

    this.logger.log('⏰ [CRON JOB] Starting automated daily stock price update...');

    try {
      let updatedCount = 0;

      for (const stockInfo of this.initialStocks) {
        try {
          const data = await this.fetchEodPriceFromMassive(stockInfo.symbol);

          if (data?.price == null || Number.isNaN(data.price)) {
            this.logger.warn(`[SKIPPED] ${stockInfo.symbol}: no price data from API`);
          } else {
            const targetDate = data.priceDate || this.getYesterdayDateString();
            await this.saveStockPrice(stockInfo, data, targetDate);
            updatedCount++;

            this.logger.log(
              `[UPDATED SUCCESS] ${stockInfo.symbol} (${targetDate}): Close=$${data.price}, MarketCap=$${data.marketCap}`,
            );
          }
        } catch (err) {
          const error = err as Error;
          this.logger.error(`[UPDATE ERROR] ${stockInfo.symbol}: ${error.message}`, error.stack);
        }

        await this.delay(12500);
      }

      return {
        message: 'Stock prices updated successfully',
        updated_stocks: updatedCount,
      };
    } finally {
      this.isUpdating = false;
    }
  }

  async getAllStocks() {
    return await this.stockRepository.find({
      order: {
        price_date: 'DESC',
        symbol: 'ASC',
      },
    });
  }
}