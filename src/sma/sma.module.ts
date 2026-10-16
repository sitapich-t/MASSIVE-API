import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SmaController } from './sma.controller';
import { SmaService } from './sma.service';
import { PriceHistory } from './entities/price-history.entity';
import { SmaRecord } from './entities/sma-record.entity';
import { PriceAlertModule } from '../price-alert/stock-price.module';

@Module({
  imports: [TypeOrmModule.forFeature([PriceHistory, SmaRecord]),
  PriceAlertModule,
  ],
  controllers: [SmaController],
  providers: [SmaService],
  exports: [SmaService],
})
export class SmaModule {}