import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity('stocks')
export class StockEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ unique: true })
  symbol: string;

  
  @Column({ name: 'name', nullable: true })
  name: string;

  
  @Column('decimal', { name: 'eod_price', precision: 10, scale: 2 })
  eod_price: number;

  
  @Column('bigint', { name: 'market_cap', default: 0 })
  market_cap: number;
}
