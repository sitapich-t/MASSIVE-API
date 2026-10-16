import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { StocksController } from './stocks.controller';
import { StocksService } from './stocks.service';
import { ComparisonHistory } from './entities/comparison-history.entity';

@Module({
  // ผูก Entity กับ DB เพื่อให้ Service เรียกใช้ Repository ได้
  imports: [TypeOrmModule.forFeature([ComparisonHistory])],
  controllers: [StocksController], // ตัวจัดการ Routes/API
  providers: [StocksService],       // ตัวประมวลผล Business Logic
  exports: [StocksService],          // แชร์ Service ให้โมดูลอื่นดึงไปใช้ได้
})
export class StockComparisonModule {}
