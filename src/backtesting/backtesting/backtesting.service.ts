import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { TradeRecord } from './entities/trade-record.entity';
import { SmaRecord } from './../../sma/entities/sma-record.entity';
import { SimulateTradeDto } from './dto/simulate-trade.dto';
import { Stock } from '../../price-alert/entities/stock.entity';
import { SmaService } from '../../sma/sma.service';

const DEFAULT_SHORT_PERIOD = 5;
const DEFAULT_LONG_PERIOD = 20;

// จำนวนวันต่อ 1 หน่วยของ timeframe
const UNIT_DAYS: Record<string, number> = {
  d: 1,
  w: 7,
  m: 30,
};

interface SimulationResult {
  finalBalance: number;
  totalTrades: number;
  winningTrades: number;
}

// คืนจำนวนวันของ timeframe หรือ null ถ้ารูปแบบไม่ถูกต้อง (เช่น 2d, 10d, 2w, 3m)
const parseTimeframeStep = (timeframe: string): number | null => {
  const match = /^(\d+)([dwm])$/i.exec(timeframe.trim());
  if (!match) return null;

  const step = Number(match[1]) * UNIT_DAYS[match[2].toLowerCase()];
  return step > 0 ? step : null;
};

const toDateKey = (d: Date | string | null | undefined): string => {
  if (!d) return '';
  if (typeof d === 'string') return d.split('T')[0];
  const dateObj = new Date(d);
  if (Number.isNaN(dateObj.getTime())) return ''; // แก้ไขจุดที่ 1: ใช้ Number.isNaN
  const year = dateObj.getFullYear();
  const month = String(dateObj.getMonth() + 1).padStart(2, '0');
  const day = String(dateObj.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
};

@Injectable()
export class BacktestingService {
  constructor(
    @InjectRepository(TradeRecord)
    private readonly tradeRecordRepo: Repository<TradeRecord>,

    @InjectRepository(SmaRecord)
    private readonly smaRepo: Repository<SmaRecord>,

    @InjectRepository(Stock)
    private readonly stockRepository: Repository<Stock>,

    private readonly smaService: SmaService,
  ) {}

  async simulateTrade(dto: SimulateTradeDto) {
    const { stockSymbol, timeframe, initialBalance } = dto;
    const shortPeriod = dto.shortPeriod ?? DEFAULT_SHORT_PERIOD;
    const longPeriod = dto.longPeriod ?? DEFAULT_LONG_PERIOD;

    const priceRecords = await this.loadPriceRecords(stockSymbol, timeframe);

    const shortSmaList = await this.getOrGenerateSmaRecords(stockSymbol, shortPeriod, priceRecords);
    const longSmaList = await this.getOrGenerateSmaRecords(stockSymbol, longPeriod, priceRecords);

    const priceMap = this.buildPriceMap(priceRecords);
    const longSmaMap = this.buildSmaMap(longSmaList);

    const result = this.runStrategy(shortSmaList, longSmaMap, priceMap, initialBalance);

    return this.saveResult(stockSymbol, timeframe, initialBalance, result);
  }

  // ---------- 1. โหลด + กรองข้อมูลราคา ----------
  private async loadPriceRecords(stockSymbol: string, timeframe: string): Promise<Stock[]> {
    const step = parseTimeframeStep(timeframe);
    if (step === null) {
      throw new BadRequestException(
        `timeframe "${timeframe}" ไม่ถูกต้อง ใช้รูปแบบ เช่น 1d, 3d, 1w, 1m`,
      );
    }

    const records = await this.stockRepository.find({
      where: { symbol: stockSymbol.toUpperCase() },
      order: { price_date: 'ASC' },
    });

    if (!records.length) {
      throw new NotFoundException(`ไม่พบข้อมูลประวัติราคาของหุ้น ${stockSymbol} ในระบบ`);
    }

    return step > 1 ? records.filter((_, index) => index % step === 0) : records;
  }

  // ---------- 2. สร้าง Map ----------
  private buildPriceMap(priceRecords: Stock[]): Map<string, number> {
    return new Map<string, number>(
      priceRecords.map((p) => [toDateKey(p.price_date), Number(p.eod_price ?? 0)]),
    );
  }

  private buildSmaMap(smaList: SmaRecord[]): Map<string, number> {
    const map = new Map<string, number>();
    for (const item of smaList) {
      const key = toDateKey(item.latestDate);
      if (key) map.set(key, Number(item.smaValue));
    }
    return map;
  }

  // ---------- 3. ลูปหาสัญญาณ ----------
  private runStrategy(
    shortSmaList: SmaRecord[],
    longSmaMap: Map<string, number>,
    priceMap: Map<string, number>,
    initialBalance: number,
  ): SimulationResult {
    const state = {
      balance: initialBalance,
      holding: false,
      buyPrice: 0,
      totalTrades: 0,
      winningTrades: 0,
    };
    let prevShort: number | null = null;
    let prevLong: number | null = null;

    for (const shortData of shortSmaList) {
      const dateKey = toDateKey(shortData.latestDate);
      const currShort = Number(shortData.smaValue);
      const currLong = longSmaMap.get(dateKey);
      const price = priceMap.get(dateKey);

      if (currLong !== undefined && price && prevShort !== null && prevLong !== null) {
        this.processTradeStep(
          state,
          { short: prevShort, long: prevLong },
          { short: currShort, long: currLong },
          price,
        );
      }

      prevShort = currShort;
      prevLong = currLong ?? null;
    }

    return {
      finalBalance: state.balance,
      totalTrades: state.totalTrades,
      winningTrades: state.winningTrades,
    };
  }

  // แก้ไขจุดที่ 2: แยก Helper Function เพื่อลด Cognitive Complexity
  private processTradeStep(
    state: { balance: number; holding: boolean; buyPrice: number; totalTrades: number; winningTrades: number },
    prev: { short: number; long: number },
    curr: { short: number; long: number },
    price: number,
  ) {
    const goldenCross = prev.short <= prev.long && curr.short > curr.long;
    const deathCross = prev.short >= prev.long && curr.short < curr.long;

    if (goldenCross && !state.holding) {
      state.holding = true;
      state.buyPrice = price;
    } else if (deathCross && state.holding) {
      state.holding = false;
      state.totalTrades++;
      const pnl = price - state.buyPrice;
      state.balance += pnl;
      if (pnl > 0) state.winningTrades++;
    }
  }

  // ---------- 4. สรุปผล + บันทึก ----------
  private async saveResult(
    stockSymbol: string,
    timeframe: string,
    initialBalance: number,
    { finalBalance, totalTrades, winningTrades }: SimulationResult,
  ) {
    const profit = Number((finalBalance - initialBalance).toFixed(2));
    const winRate =
      totalTrades > 0 ? Number(((winningTrades / totalTrades) * 100).toFixed(2)) : 0;

    const tradeRecord = this.tradeRecordRepo.create({
      symbol: stockSymbol.toUpperCase(),
      timeframe,
      initialCapital: initialBalance,
      finalBalance: Number(finalBalance.toFixed(2)),
      profit,
      winRate,
      status: profit >= 0 ? 'PROFIT' : 'LOSS',
    });

    const savedRecord = await this.tradeRecordRepo.save(tradeRecord);

    return {
      message: 'Backtesting simulation completed successfully',
      data: savedRecord,
    };
  }

  private async getOrGenerateSmaRecords(
    symbol: string,
    period: number,
    priceRecords: Stock[],
  ): Promise<SmaRecord[]> {
    return this.smaService.getOrGenerateSmaSeries(symbol.toUpperCase(), period, priceRecords);
  }
}