import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity()
export class EconomicEvent {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  event_name: string;

  @Column()
  country: string;

  @Column()
  impact: string;

  @Column()
  actual: string;

  @Column()
  forecast: string;

  @Column()
  previous: string;

  @Column()
  date_time: string;

  @Column({ nullable: true })
  sentiment: string;
}