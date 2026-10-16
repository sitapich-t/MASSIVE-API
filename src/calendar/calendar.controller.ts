import { Controller, Get } from '@nestjs/common';
import { CalendarService } from './calendar.service';

@Controller('api/v1/calendar')
export class CalendarController {
  constructor(private readonly calendarService: CalendarService) {}

  @Get('events')
  async getEvents() {
    const events = await this.calendarService.findAll();
    return {
      status: 'success',
      data: events,
    };
  }
}