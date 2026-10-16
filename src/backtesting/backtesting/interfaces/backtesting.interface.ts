export interface TradeSimulationResult {
  symbol: string;
  timeframe: string;
  initialCapital: number;
  finalBalance: number;
  profit: number;
  winRate: number;
  status: 'PROFIT' | 'LOSS';
  savedRecordId?: number; //  เปลี่ยนจาก string เป็น number ให้ตรงกับ id (int)
}