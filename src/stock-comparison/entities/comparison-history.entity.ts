import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn } from 'typeorm';

@Entity()
export class ComparisonHistory {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  stock1: string;

  @Column()
  stock2: string;

  @Column()
  timeframe: string;

  // เพิ่มฟิลด์เก็บค่า Correlation (ใส่ nullable ไว้เผื่อข้อมูลเก่าไม่มีค่านี้)
  @Column('float', { nullable: true })
  correlationCoefficient: number;

  @CreateDateColumn()
  comparedAt: Date;
}