import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, UpdateDateColumn } from 'typeorm';

@Entity('watchlists')
export class Watchlist {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  user_id: string;

  @Column('simple-array')
  symbols: string[]; // เก็บรายชื่อหุ้นผสมกันในช่องเดียว เช่น ["MSFT","NVDA"]

  @Column({ type: 'varchar', length: 10 })
  comparison_period: string; // เก็บค่า "1DAY", "3DAY", "7DAY"

  @Column('simple-array')
  report_fields: string[];

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;
}