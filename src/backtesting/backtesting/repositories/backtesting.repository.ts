import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { TradeRecord } from '../entities/trade-record.entity';

@Injectable()
export class BacktestingRepository {
  constructor(
    @InjectRepository(TradeRecord)
    private readonly repo: Repository<TradeRecord>,
  ) {}

  async saveRecord(data: Partial<TradeRecord>): Promise<TradeRecord> {
    const record = this.repo.create(data);
    return await this.repo.save(record);
  }
}