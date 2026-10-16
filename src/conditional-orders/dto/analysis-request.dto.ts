import { IsString, IsNumber, IsOptional } from 'class-validator';

export class AnalysisRequestDto {
  @IsString()
  symbol: string;

  @IsString()
  date: string;

  @IsOptional()
  @IsNumber()
  putVolume?: number; // ปริมาณ Put Options

  @IsOptional()
  @IsNumber()
  callVolume?: number; // ปริมาณ Call Options

  @IsOptional()
  @IsNumber()
  shortVolume?: number; // ปริมาณ Short Sale
}