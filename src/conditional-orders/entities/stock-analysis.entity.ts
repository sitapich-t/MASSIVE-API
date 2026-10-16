import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn } from 'typeorm';

@Entity('stock_analysis')
export class StockAnalysisEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  symbol: string;

  @Column()
  date: string;

  @Column('float')
  closePrice: number;

  @Column('float')
  volume: number;

  @Column('float')
  volumeSurgeRatio: number; // วอลุ่มผิดปกติกี่เท่าเทียบค่าเฉลี่ย 252 วัน

  @Column('float')
  crowdedScore: number; // คะแนนความตึงตัวของเม็ดเงิน (0-100) จากข้อมูลจริง

  @Column()
  percentileRank: string; // เช่น "85.5%"

  @Column()
  colorZone: string; // GREEN, YELLOW, RED

  @Column()
  status: string; // LOW, NORMAL, EXTREMELY_CROWDED

  @Column()
  reversalSignal: string; // สัญญาณจุดกลับตัว

  @Column('float')
  riskRewardRatio: number; // อัตราส่วน Risk-to-Reward

  @CreateDateColumn()
  createdAt: Date;
}