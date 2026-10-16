import { Injectable, BadRequestException, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, ILike } from 'typeorm';
import { Stock } from '../price-alert/entities/stock.entity';
import { SmaRecord } from '../sma/entities/sma-record.entity';
import { WatchlistService } from '../watchlist/watchlist.service';
import { StocksService } from '../stock-comparison/stocks.service';
import { StockPriceService } from '../price-alert/stock-price.service';

@Injectable()
export class StockScreenerService {
  private readonly logger = new Logger(StockScreenerService.name);

  constructor(
    @InjectRepository(Stock)
    private readonly stockRepository: Repository<Stock>,
    @InjectRepository(SmaRecord)
    private readonly smaRepository: Repository<SmaRecord>,
    private readonly watchlistService: WatchlistService,
    private readonly comparisonService: StocksService,
    private readonly priceAlertService: StockPriceService,
  ) {}

  // 1. Logic ดึงข้อมูลจาก DB กลาง และแมตช์ค่า SMA ล่าสุด (รองรับ min และ max market cap)
  async screenStocks(criteria: { min_market_cap?: number; max_market_cap?: number }) {
    const minMarketCap = criteria.min_market_cap || 0;
    const maxMarketCap = criteria.max_market_cap;

    // สร้าง QueryBuilder ตั้งค่าขั้นต่ำ min_market_cap
    const query = this.stockRepository
      .createQueryBuilder('stock')
      .where('stock.market_cap >= :minMarketCap', { minMarketCap });

    // เพิ่มเงื่อนไข max_market_cap หากมีการส่งค่ามา
    if (maxMarketCap !== undefined && maxMarketCap !== null) {
      query.andWhere('stock.market_cap <= :maxMarketCap', { maxMarketCap });
    }

    // ดึงข้อมูลหุ้นเรียงจากวันที่ใหม่สุดลงไป
    const stocks = await query
      .orderBy('stock.price_date', 'DESC')
      .getMany();

    // กรองเอาเฉพาะหุ้นตัวล่าสุดของแต่ละ Symbol (พร้อมเช็คกรณี symbol เป็น null/undefined)
    const latestStocksMap = new Map<string, Stock>();
    for (const stock of stocks) {
      if (stock.symbol && !latestStocksMap.has(stock.symbol)) {
        latestStocksMap.set(stock.symbol, stock);
      }
    }

    const uniqueStocks = Array.from(latestStocksMap.values());

    const results = await Promise.all(
      uniqueStocks.map(async (stock) => {
        // ใช้ Optional Chaining และ Fallback ป้องกัน stock.symbol เป็น null
        const cleanSymbol = stock.symbol?.trim() ?? '';

        // ค้นหาเรคคอร์ด SMA ล่าสุดกรณีมี cleanSymbol
        const smaData = cleanSymbol
          ? await this.smaRepository.findOne({
              where: { symbol: ILike(cleanSymbol) },
              order: { id: 'DESC' },
            })
          : null;

        // Safe type narrowing เพื่อค้นหาฟิลด์ SMA โดยไม่ใช้ as any
        let rawSma: number | null = null;
        if (smaData) {
          const possibleValues = Object.entries(smaData)
            .filter(([key]) => ['smaValue', 'sma_value', 'sma', 'value', 'sma20', 'sma50'].includes(key))
            .map(([, val]) => val);

          for (const val of possibleValues) {
            if (val !== undefined && val !== null) {
              rawSma = Number(val);
              break;
            }
          }
        }

        return {
          symbol: stock.symbol,
          name: stock.name,
          industry: stock.industry,
          closePrice: stock.eod_price !== null && stock.eod_price !== undefined ? Number(stock.eod_price) : null,
          marketCap: stock.market_cap !== null && stock.market_cap !== undefined ? Number(stock.market_cap) : null,
          priceDate: stock.price_date,
          sma: rawSma !== null && !Number.isNaN(rawSma) ? rawSma : null,
        };
      }),
    );

    return results;
  }

  // 2. Logic ส่งข้อมูลไปยังโมดูลเพื่อน (Watchlist / Compare / Alert / All)
  async dispatchSelectedStock(dto: {
    symbol: string;
    secondSymbol?: string;
    action: 'watchlist' | 'compare' | 'alert' | 'all';
    targetValue?: number;
    comparison_period?: string;
    user_id?: string;
    report_fields?: string[];
  }) {
    const { 
      symbol, 
      secondSymbol, 
      action, 
      targetValue, 
      comparison_period, 
      user_id, 
      report_fields 
    } = dto;

    // Helper เช็คข้อมูลสำหรับ Watchlist
    const validateAndGetWatchlistPayload = () => {
      if (!user_id) {
        throw new BadRequestException('user_id is required for watchlist action');
      }
      if (!comparison_period) {
        throw new BadRequestException('comparison_period is required for watchlist action');
      }
      if (!report_fields || report_fields.length === 0) {
        throw new BadRequestException('report_fields is required for watchlist action');
      }

      return {
        user_id,
        symbols: [symbol],
        comparison_period,
        report_fields,
      };
    };

    switch (action) {
      case 'watchlist': {
        const watchlistPayload = validateAndGetWatchlistPayload();
        return await this.watchlistService.saveWatchlist(watchlistPayload);
      }

      case 'compare': {
        if (!secondSymbol) {
          throw new BadRequestException('secondSymbol is required for comparison action');
        }
        if (!comparison_period) {
          throw new BadRequestException('comparison_period is required for comparison action');
        }
        return await this.comparisonService.compareStocks(
          symbol, 
          secondSymbol, 
          comparison_period
        );
      }

      case 'alert': {
        if (!targetValue) {
          throw new BadRequestException('targetValue is required for alert action');
        }
        if (!user_id) {
          throw new BadRequestException('user_id is required for alert action');
        }
        return await this.priceAlertService.createPriceAlert({
          user_id,
          symbol,
          target_price: targetValue,
        });
      }

      case 'all': {
        const watchlistPayload = validateAndGetWatchlistPayload();

        if (!secondSymbol) {
          throw new BadRequestException('secondSymbol is required when action is "all"');
        }
        if (!targetValue) {
          throw new BadRequestException('targetValue is required when action is "all"');
        }
        if (!user_id) {
          throw new BadRequestException('user_id is required when action is "all"');
        }

        const [watchlistRes, compareRes, alertRes] = await Promise.all([
          this.watchlistService.saveWatchlist(watchlistPayload),
          this.comparisonService.compareStocks(
            symbol, 
            secondSymbol, 
            comparison_period
          ),
          this.priceAlertService.createPriceAlert({
            user_id,
            symbol,
            target_price: targetValue,
          }),
        ]);

        return {
          message: 'Successfully dispatched to Watchlist, Comparison, and PriceAlert services',
          results: {
            watchlist: watchlistRes,
            compare: compareRes,
            alert: alertRes,
          },
        };
      }

      default:
        throw new BadRequestException('Invalid action type');
    }
  }
}