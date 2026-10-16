import { Injectable, Logger, OnModuleInit } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { firstValueFrom } from 'rxjs';
import { EconomicEvent } from './entities/economic-event.entity';

@Injectable()
export class CalendarService implements OnModuleInit {
  private readonly logger = new Logger(CalendarService.name);

  constructor(
    @InjectRepository(EconomicEvent)
    private readonly eventRepository: Repository<EconomicEvent>,
    private readonly httpService: HttpService,
  ) {}

  async onModuleInit() {
    await this.fetchAndSyncExternalEvents();
  }

  async fetchAndSyncExternalEvents(): Promise<void> {
    try {
      const apiKey = 'dafgt5hr01quvmmfhc4gdafgt5hr01quvmmfhc50';
      const url = `https://finnhub.io/api/v1/news?category=general&token=${apiKey}`;

      this.logger.log('กำลังยิงดึงข้อมูลจาก Finnhub API...');

      const response = await firstValueFrom(this.httpService.get(url));
      const newsData = response.data;

      if (newsData && Array.isArray(newsData) && newsData.length > 0) {
        for (const item of newsData.slice(0, 15)) {
          const headline = item.headline || '';
          
          // วิเคราะห์ Sentiment เบื้องต้นจากเนื้อหาข่าว
          let sentiment = 'NEUTRAL';
          const lowerHeadline = headline.toLowerCase();
          if (
            lowerHeadline.includes('rise') ||
            lowerHeadline.includes('gain') ||
            lowerHeadline.includes('high') ||
            lowerHeadline.includes('jump') ||
            lowerHeadline.includes('growth')
          ) {
            sentiment = 'BULLISH';
          } else if (
            lowerHeadline.includes('fall') ||
            lowerHeadline.includes('drop') ||
            lowerHeadline.includes('war') ||
            lowerHeadline.includes('strike') ||
            lowerHeadline.includes('cut')
          ) {
            sentiment = 'BEARISH';
          }

          const newEvent = this.eventRepository.create({
            event_name: headline || 'Market News',
            country: 'US',
            impact: 'MEDIUM',
            actual: item.source || 'News',
            forecast: '-',
            previous: '-',
            sentiment: sentiment,
            date_time: new Date(item.datetime * 1000).toISOString(),
          });

          await this.eventRepository.save(newEvent);
        }
        this.logger.log('บันทึกข้อมูลสำเร็จแล้ว');
      }
    } catch (error) {
      this.logger.error('เกิดข้อผิดพลาดในการดึงข้อมูล:', error);
    }
  }

  async findAll(): Promise<EconomicEvent[]> {
    return this.eventRepository.find({ order: { date_time: 'DESC' } });
  }
}