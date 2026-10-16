import { IsOptional, IsInt, Min } from 'class-validator';
import { Type } from 'class-transformer';

export class HistoryQueryDto {
  // ไม่ส่งมาก็ได้ (Optional) แต่ถ้าส่งมาต้องแปลงเป็นตัวเลขและห้ามต่ำกว่า 1
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  page?: number = 1; // ค่าเริ่มต้นคือหน้า 1

  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  limit?: number = 10; // ค่าเริ่มต้นคือ 10 รายการต่อหน้า
}