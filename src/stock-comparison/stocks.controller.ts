import { Controller, Post, Query } from '@nestjs/common';
import { StocksService } from './stocks.service';

@Controller('api/v1/stocks')
export class StocksController {
  constructor(private readonly stocksService: StocksService) {}

  @Post('compare') //กำหนด Endpoint รับ HTTP POST Request ที่ Path /api/v1/stocks/compare แล้วตั้งค่าเริ่มต้นไว้ก่อน
  async compareStocks(
    @Query('stock1') stock1: string = 'AAPL',
    @Query('stock2') stock2: string = 'TSLA',
    @Query('timeframe') timeframe: string = '7d',
  ) {
    return this.stocksService.compareStocks(stock1, stock2, timeframe);
  }
}
