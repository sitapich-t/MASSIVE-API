import { IsString, IsNumber, IsOptional, Min, IsArray, IsEnum } from 'class-validator';

// DTO สำหรับรับข้อมูลคัดกรองหุ้น
export class StockScreenerDto {
  @IsOptional()
  @IsNumber()
  @Min(1)
  ema_period?: number;

  @IsOptional()
  @IsNumber()
  @Min(0)
  min_volume?: number;

  @IsOptional()
  @IsNumber()
  @Min(0)
  min_market_cap?: number;

  @IsOptional()
  @IsNumber()
  @Min(0)
  max_market_cap?: number;
}

// DTO สำหรับ Watchlist
export class WatchlistDto {
  @IsString()
  symbol!: string;
}

// DTO สำหรับเปรียบเทียบหุ้น
export class StockCompareDto {
  @IsArray()
  @IsString({ each: true })
  symbols!: string[];
}

// DTO สำหรับแจ้งเตือนราคา
export class StockAlertDto {
  @IsString()
  symbol!: string;

  @IsNumber()
  target_price!: number;

  @IsEnum(['ABOVE', 'BELOW'])
  condition!: 'ABOVE' | 'BELOW';
}