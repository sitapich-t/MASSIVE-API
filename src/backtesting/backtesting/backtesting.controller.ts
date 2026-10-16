import { Controller, Post, Body, HttpCode, HttpStatus } from '@nestjs/common';
import { BacktestingService } from './backtesting.service';
import { SimulateTradeDto } from './dto/simulate-trade.dto';

@Controller('backtesting')
export class BacktestingController {
  constructor(private readonly backtestingService: BacktestingService) {}

  @Post('simulate')
  @HttpCode(HttpStatus.OK)
  async simulateTrade(@Body() dto: SimulateTradeDto) {
    return this.backtestingService.simulateTrade(dto);
  }
}