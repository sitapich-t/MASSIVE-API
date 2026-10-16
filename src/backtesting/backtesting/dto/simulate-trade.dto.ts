import { IsString, IsNotEmpty, IsOptional, IsNumber, IsInt, IsIn } from 'class-validator';

export class SimulateTradeDto {
  @IsString()
  @IsNotEmpty()
  stockSymbol: string;

  @IsString()
  @IsNotEmpty()
  timeframe: string;

  @IsNumber()
  @IsNotEmpty()
  initialBalance: number;

  // ช่วง SMA เส้นสั้น (เร็ว) — ถ้าไม่ส่งมาจะ default เป็น 5
  @IsOptional()
  @IsInt()
  @IsIn([5, 10, 20, 30, 50, 90, 180, 200])
  shortPeriod?: number;

  // ช่วง SMA เส้นยาว (ช้า) — ถ้าไม่ส่งมาจะ default เป็น 20
  @IsOptional()
  @IsInt()
  @IsIn([5, 10, 20, 30, 50, 90, 180, 200])
  longPeriod?: number;
}