import { Entity, PrimaryGeneratedColumn, Column, Unique } from 'typeorm';

@Entity('price_alert_stocks')
@Unique(['symbol', 'price_date'])
export class Stock {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'varchar', nullable: true })
  symbol: string| null;
  @Column({ type: 'varchar', nullable: true })
  name: string | null;

  @Column({ type: 'varchar', nullable: true })
  industry: string | null;

  @Column({ type: 'numeric', precision: 12, scale: 4, nullable: true })
  eod_price: number | null;
  
  @Column({ type: 'date' })
  price_date: string;
  
  @Column({ type: 'numeric', precision: 20, scale: 2, nullable: true })
  market_cap: number | null;

  @Column({ type: 'timestamp', nullable: true })
  created_at: Date | null;

  @Column({ type: 'timestamp', nullable: true })
  updated_at: Date | null;

  @Column({ type: 'numeric', precision: 12, scale: 4, nullable: true })
  open: number | null;

  @Column({ type: 'numeric', precision: 12, scale: 4, nullable: true })
  high: number | null;

  @Column({ type: 'numeric', precision: 12, scale: 4, nullable: true })
  low: number | null;

  @Column({ type: 'bigint', nullable: true })
  volume: number | null;

}