import { IsNotEmpty, IsString, IsIn } from 'class-validator';

export class CompareStocksDto {
  // เช็คว่า stock1 ต้องไม่ว่างเปล่า และเป็นข้อความ
  @IsNotEmpty({ message: 'กรุณาระบุสัญลักษณ์หุ้นตัวที่ 1' })
  @IsString()
  stock1: string;

  // เช็คว่า stock2 ต้องไม่ว่างเปล่า และเป็นข้อความ
  @IsNotEmpty({ message: 'กรุณาระบุสัญลักษณ์หุ้นตัวที่ 2' })
  @IsString()
  stock2: string;

  // เช็คว่า timeframe ต้องไม่ว่าง และต้องเป็นค่า 1d, 7d, 30d, 90d เท่านั้น
  @IsNotEmpty({ message: 'กรุณาระบุ timeframe' })
  @IsIn(['1d', '7d', '30d', '90d'], {
    message: 'timeframe ต้องเป็น 1d, 7d, 30d หรือ 90d เท่านั้น',
  })
  timeframe: string;
}