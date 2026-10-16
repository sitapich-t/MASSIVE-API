import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { BacktestingController } from './backtesting.controller';
import { BacktestingService } from './backtesting.service';
import { TradeRecord } from './entities/trade-record.entity';
import { SmaRecord } from './../../sma/entities/sma-record.entity';
import { PriceHistory } from './../../sma/entities/price-history.entity';
import { Stock } from '../../price-alert/entities/stock.entity';
import { SmaModule } from '../../sma/sma.module';


@Module({
  imports: [
    TypeOrmModule.forFeature([TradeRecord, SmaRecord, PriceHistory, Stock]),
    SmaModule, 
  ],
  controllers: [BacktestingController],
  providers: [BacktestingService],
  exports: [BacktestingService],
})
export class BacktestingModule {}