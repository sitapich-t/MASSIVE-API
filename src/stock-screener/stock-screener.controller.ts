import { Controller, Post, Body } from '@nestjs/common';
import { StockScreenerService } from './stock-screener.service';

@Controller('stock-screener') // เปลี่ยนเพื่อป้องกัน route ชนกับเพื่อน
export class StockScreenerController {
  constructor(private readonly stockScreenerService: StockScreenerService) {}

  // Endpoint 1: คัดกรองหุ้น
  // URL: POST http://localhost:3000/stock-screener/screen
 @Post('screen')
  async screenStocks(
    @Body('min_market_cap') minMarketCap?: number,
    @Body('max_market_cap') maxMarketCap?: number, 
  ) {
    return await this.stockScreenerService.screenStocks({
      min_market_cap: minMarketCap,
      max_market_cap: maxMarketCap, 
    });
  }

  // Endpoint 2: ส่งข้อมูลหุ้นไปยังโมดูลต่างๆ
  // URL: POST http://localhost:3000/stock-screener/action
  @Post('action')
  async handleUserAction(
    @Body()
    body: {
      symbol: string;
      secondSymbol?: string;
      action: 'watchlist' | 'compare' | 'alert' | 'all';
      targetValue?: number;
      comparison_period?: string;
      user_id?: string;
      report_fields?: string[];
    },
  ) {
    return await this.stockScreenerService.dispatchSelectedStock(body);
  }
}