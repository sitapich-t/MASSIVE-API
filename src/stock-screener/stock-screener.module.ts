import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { StockScreenerController } from './stock-screener.controller';
import { StockScreenerService } from './stock-screener.service';
import { Stock } from '../price-alert/entities/stock.entity';
import { SmaRecord } from '../sma/entities/sma-record.entity';
import { WatchlistModule } from '../watchlist/watchlist.module';
import { StockComparisonModule } from '../stock-comparison/stocks.module';
import { PriceAlertModule } from '../price-alert/stock-price.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([Stock, SmaRecord]),
    WatchlistModule,
    StockComparisonModule,
    PriceAlertModule,
  ],
  controllers: [StockScreenerController],
  providers: [StockScreenerService],
})
export class StockScreenerModule {}
