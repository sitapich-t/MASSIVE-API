// รายชื่อหุ้น 10 ตัวที่ระบบรองรับ
export const ALLOWED_STOCKS = [
  'MSFT', 'NVDA', 'LLY', 'JNJ', 'JPM', 'V', 'AMZN', 'DIS', 'XOM', 'CVX',
] as const;

// ช่วงเวลาเปรียบเทียบที่รองรับ 1DAY 3DAY 7DAY
export const ALLOWED_COMPARISON_PERIODS = ['1DAY', '3DAY', '7DAY'] as const;

// ข้อมูลที่สามารถเลือกให้รายงาน price volume, RSI
export const ALLOWED_REPORT_FIELDS = ['price', 'volume', 'RSI'] as const;
