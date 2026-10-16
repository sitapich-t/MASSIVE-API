import { Controller, Post, Body, HttpCode, HttpStatus } from '@nestjs/common';
import { WatchlistService } from './watchlist.service';
import { CreateWatchlistDto } from './dto/create-watchlist.dto';
import { RunMarketCloseDto } from './dto/run-market-close.dto';

@Controller('api/v1/watchlist')
export class WatchlistController {
  constructor(private readonly watchlistService: WatchlistService) {}

  @Post()
  @HttpCode(HttpStatus.CREATED)
  async createWatchlist(@Body() createWatchlistDto: CreateWatchlistDto) {
    return await this.watchlistService.saveWatchlist(createWatchlistDto);
  }

  @Post('run-market-close')
  @HttpCode(HttpStatus.OK)
  async runMarketClose(@Body() runMarketCloseDto: RunMarketCloseDto) {
    return await this.watchlistService.processMarketClose(runMarketCloseDto.user_id);
  }
}