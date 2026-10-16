import { Controller, Post, Body, HttpCode, HttpStatus } from '@nestjs/common';
import { ConditionalOrdersService } from './conditional-orders.service';
import { AnalysisRequestDto } from './dto/analysis-request.dto';

@Controller('api/v1/stocks')
export class ConditionalOrdersController {
  constructor(private readonly conditionalOrdersService: ConditionalOrdersService) {}

  @Post('analysis')
  @HttpCode(HttpStatus.OK)
  async analyze(@Body() dto: AnalysisRequestDto) {
    return await this.conditionalOrdersService.calculateAnalysis(dto);
  }
}