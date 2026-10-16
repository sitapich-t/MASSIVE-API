import { Injectable, BadRequestException, InternalServerErrorException } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { firstValueFrom } from 'rxjs';
import { AnalysisRequestDto } from './dto/analysis-request.dto';
import { StockAnalysisEntity } from './entities/stock-analysis.entity';

interface PolygonAggregateBar {
  c: number;
  v: number;
  o?: number;
}

@Injectable()
export class ConditionalOrdersService {
  private readonly ALLOWED_SYMBOLS = [
    'MSFT', 'NVDA', 'LLY', 'JNJ', 'JPM', 
    'V', 'AMZN', 'DIS', 'XOM', 'CVX'
  ];

  constructor(
    private readonly httpService: HttpService,
    private readonly configService: ConfigService,
    @InjectRepository(StockAnalysisEntity)
    private readonly analysisRepo: Repository<StockAnalysisEntity>,
  ) {}

  private getStartDate(dateString: string): string {
    const date = new Date(dateString);
    date.setFullYear(date.getFullYear() - 1);
    return date.toISOString().split('T')[0];
  }

  private calculatePercentileRank(arr: number[], currentValue: number): number {
    if (!arr || arr.length === 0) return 50;
    const countBelow = arr.reduce((acc, v) => acc + (v < currentValue ? 1 : 0) + (v === currentValue ? 0.5 : 0), 0);
    return Number(((countBelow / arr.length) * 100).toFixed(1));
  }

  async calculateAnalysis(dto: AnalysisRequestDto) {
    const symbol = dto.symbol.toUpperCase();
    const { date } = dto;

    if (!this.ALLOWED_SYMBOLS.includes(symbol)) {
      throw new BadRequestException(`สัญลักษณ์หุ้น '${symbol}' ไม่ได้รับอนุญาตให้วิเคราะห์ (ไม่อยู่ใน Whitelist)`);
    }

    const apiKey = this.configService.get<string>('POLYGON_API_KEY');
    if (!apiKey) {
      throw new InternalServerErrorException('ไม่พบ POLYGON_API_KEY ในไฟล์กำหนดค่า (.env)');
    }

    try {
      // 1. ดึงข้อมูล Aggregate ย้อนหลัง 1 ปี จาก Polygon.io
      const startDate = this.getStartDate(date);
      const url = `https://api.polygon.io/v2/aggs/ticker/${symbol}/range/1/day/${startDate}/${date}?adjusted=true&sort=asc&limit=500&apiKey=${apiKey}`;
      const response = await firstValueFrom(this.httpService.get(url));
      const results: PolygonAggregateBar[] = response.data?.results;

      if (!results || results.length === 0) {
        throw new BadRequestException(`ไม่พบข้อมูลราคาหุ้นย้อนหลังสำหรับ ${symbol} จนถึงวันที่ ${date}`);
      }

      // 2. คำนวณ Volume เฉลี่ยย้อนหลังจริง (SMA Volume 252 วัน)
      const totalVolume = results.reduce((sum, bar) => sum + bar.v, 0);
      const avgVolume = totalVolume / results.length;

      // แก้ไขใช้ .at(-1) เพื่อดึงตัวสุดท้ายตาม Linter Warning
      const currentDayData = results.at(-1)!;
      const closePrice = currentDayData.c;
      const volume = currentDayData.v;
      const volumeSurgeRatio = Number((volume / avgVolume).toFixed(2));

      // 3. คำนวณ Crowded Score จากข้อมูลจริง
      const historicalScores: number[] = results.map((bar: PolygonAggregateBar) => {
        const barSurge = bar.v / avgVolume;
        const priceVolatility = bar.o ? Math.abs((bar.c - bar.o) / bar.o) * 100 : 1;
        const score = (barSurge * 40) + (priceVolatility * 10);
        return Number(Math.min(100, Math.max(0, score)).toFixed(1));
      });

      // แก้ไขใช้ .at(-1) เพื่อดึงตัวสุดท้ายตาม Linter Warning
      const currentCrowdedScore = historicalScores.at(-1)!;
      const percentileRank = this.calculatePercentileRank(historicalScores, currentCrowdedScore);

      // 4. ตัดเกรด colorZone
      let colorZone: 'GREEN' | 'YELLOW' | 'RED';
      let statusText: string;

      if (percentileRank <= 30) {
        colorZone = 'GREEN';
        statusText = 'LOW';
      } else if (percentileRank <= 85) {
        colorZone = 'YELLOW';
        statusText = 'NORMAL';
      } else {
        colorZone = 'RED';
        statusText = 'EXTREMELY_CROWDED';
      }

      // 5. ประเมิน Reversal Signal
      let reversalSignal = 'NEUTRAL';
      if (colorZone === 'RED') {
        reversalSignal = volumeSurgeRatio > 2.0 ? 'HIGH_REVERSAL_RISK' : 'OVERBOUGHT_WARN';
      }

      // 6. กำหนดเปอร์เซ็นต์ Risk & Reward สัมพันธ์กับ colorZone
      let riskPct = 0.02;   // GREEN: Risk 2%
      let rewardPct = 0.08; // GREEN: Reward 8% (1:4)

      if (colorZone === 'YELLOW') {
        riskPct = 0.03;   // YELLOW: Risk 3%
        rewardPct = 0.06; // YELLOW: Reward 6% (1:2)
      } else if (colorZone === 'RED') {
        riskPct = 0.05;   // RED: Risk 5%
        rewardPct = 0.025; // RED: Reward 2.5% (1:0.5)
      }

      const estimatedRisk = closePrice * riskPct;
      const estimatedReward = closePrice * rewardPct;
      const riskRewardRatio = Number((estimatedReward / estimatedRisk).toFixed(2));

      // 7. บันทึกลง Database (ปัดเศษ Volume ป้องกันปัญหา)
      const newRecord = this.analysisRepo.create({
        symbol,
        date,
        closePrice,
        volume: Number(volume.toFixed(2)),
        volumeSurgeRatio,
        crowdedScore: currentCrowdedScore,
        percentileRank: `${percentileRank}%`,
        colorZone,
        status: statusText,
        reversalSignal,
        riskRewardRatio,
      });
      await this.analysisRepo.save(newRecord);

      // 8. Return Response
      return {
        symbol,
        date,
        price_metrics: { close_price: closePrice, volume },
        market_metrics: {
          volume_surge: `${volumeSurgeRatio}x of avg`,
          avg_volume_252d: Math.round(avgVolume),
        },
        crowded_trade_analysis: {
          crowded_score: currentCrowdedScore,
          percentile_rank: `${percentileRank}%`,
          color_zone: colorZone,
          status: statusText,
        },
        reversal_evaluation: {
          signal: reversalSignal,
          risk_reward_ratio: `1:${riskRewardRatio}`,
        },
      };
    } catch (error: unknown) {
      if (error instanceof BadRequestException) {
        throw error;
      }
      
      const err = error as { response?: { data?: { error?: string } }; message?: string };
      const rawErrorMessage = err.response?.data?.error || err.message || 'ไม่ทราบสาเหตุ';

      throw new InternalServerErrorException(
        `เกิดข้อผิดพลาดในการดึงข้อมูลหรือบันทึก DB: ${rawErrorMessage}`
      );
    }
  }
}