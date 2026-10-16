import { IsNotEmpty, IsString, IsIn } from 'class-validator';

export class CreateEventDto {
  @IsNotEmpty({ message: 'กรุณาระบุชื่อเหตุการณ์' })
  @IsString()
  event_name: string;

  @IsNotEmpty({ message: 'กรุณาระบุสกุลเงิน' })
  @IsString()
  country: string;

  @IsNotEmpty({ message: 'กรุณาระบุระดับความสำคัญ' })
  @IsIn(['High', 'Medium', 'Low'], { message: 'Impact ต้องเป็น High, Medium หรือ Low เท่านั้น' })
  impact: string;

  @IsNotEmpty({ message: 'กรุณาระบุค่าตัวเลขจริง' })
  @IsString()
  actual: string;

  @IsNotEmpty({ message: 'กรุณาระบุค่าตัวเลขคาดการณ์' })
  @IsString()
  forecast: string;

  @IsNotEmpty({ message: 'กรุณาระบุวันเวลา' })
  @IsString()
  date_time: string;
}