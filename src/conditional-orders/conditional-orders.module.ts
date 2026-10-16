import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConditionalOrdersController } from './conditional-orders.controller';
import { ConditionalOrdersService } from './conditional-orders.service';
import { StockAnalysisEntity } from './entities/stock-analysis.entity';

@Module({
  imports: [
    HttpModule,
    TypeOrmModule.forFeature([StockAnalysisEntity]), // บันทึกลง DB
  ],
  controllers: [ConditionalOrdersController],
  providers: [ConditionalOrdersService],
})
export class ConditionalOrdersModule {}