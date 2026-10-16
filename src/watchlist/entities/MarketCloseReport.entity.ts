import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn, Index } from 'typeorm';

export interface ReportItem {
  symbol: string;
  comparison_period?: string;
  error?: string;
  [key: string]: unknown;
}

//ใช้เก็บรายงานหลังตลาดปิดที่คำนวณเสร็จแล้วของแต่ละ user
@Entity('market_close_reports')
export class MarketCloseReport {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Index()
  @Column()
  user_id: string;

  @Column()
  watchlist_id: string;

  @Column({ type: 'jsonb' })
  data: ReportItem[];

  @CreateDateColumn()
  created_at: Date;
}