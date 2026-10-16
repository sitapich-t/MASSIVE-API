import { IsNotEmpty, IsString } from 'class-validator';

export class RunMarketCloseDto {
  @IsString()
  @IsNotEmpty({ message: 'User ID is required.' })
  user_id: string;
}
