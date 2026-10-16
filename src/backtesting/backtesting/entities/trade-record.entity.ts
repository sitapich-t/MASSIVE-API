import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn } from 'typeorm';

@Entity('trade_records')
export class TradeRecord {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  symbol: string;

  @Column({ length: 20 }) 
  timeframe: string;

  @Column('float')
  initialCapital: number;

  @Column('float')
  finalBalance: number;

  @Column('float')
  profit: number;

  @Column('float')
  winRate: number;

  @Column()
  status: string;

  @CreateDateColumn()
  createdAt: Date;


}