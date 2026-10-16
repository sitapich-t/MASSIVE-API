import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CalendarController } from './calendar.controller';
import { CalendarService } from './calendar.service';
import { EconomicEvent } from './entities/economic-event.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([EconomicEvent]),
    HttpModule, // นำเข้า HttpModule สำหรับยิง API
  ],
  controllers: [CalendarController],
  providers: [CalendarService],
})
export class CalendarModule {}