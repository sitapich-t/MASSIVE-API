import { ArrayNotEmpty, IsArray, IsIn, IsNotEmpty, IsString } from 'class-validator';
import { ALLOWED_COMPARISON_PERIODS, ALLOWED_REPORT_FIELDS, ALLOWED_STOCKS } from '../constants';

export class CreateWatchlistDto {
  @IsString()
  @IsNotEmpty({ message: 'กรุณาระบุ user_id' })
  user_id: string;

  @IsArray()
  @ArrayNotEmpty({ message: 'กรุณากรอกสัญลักษณ์หุ้นอย่างน้อย 1 ตัว' })
  @IsIn(ALLOWED_STOCKS, {
    each: true,
    message: `รองรับเฉพาะหุ้น: ${ALLOWED_STOCKS.join(', ')}`,
  })
  symbols: string[];

  @IsIn(ALLOWED_COMPARISON_PERIODS, {
    message: `เวลาที่ต้องการเปรียนเทียบต้องเป็นหนึ่งใน: ${ALLOWED_COMPARISON_PERIODS.join(', ')}`,
  })
  comparison_period: string;

  @IsArray()
  @ArrayNotEmpty({ message: 'กรุณาเลือกข้อมูลที่ต้องการให้แสดงในรายงานอย่างน้อย 1 อย่าง' })
  @IsIn(ALLOWED_REPORT_FIELDS, {
    each: true,
    message: `ข้อมูลที่ต้องการให้รายงานต้องเป็นหนึ่งใน: ${ALLOWED_REPORT_FIELDS.join(', ')}`,
  })
  report_fields: string[];
}