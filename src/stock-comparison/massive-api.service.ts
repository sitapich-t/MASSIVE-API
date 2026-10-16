import { Injectable, Logger } from '@nestjs/common';
// นำเข้าฟังก์ชันสุ่มตัวเลขแบบปลอดภัยจากโมดูล crypto ของ Node.js (แทน Math.random)
import { randomInt } from 'node:crypto';
 
@Injectable()
export class MassiveApiService {
  // สร้างตัวแปร Logger สำหรับบันทึกข้อความหรือข้อผิดพลาดลงบน Terminal โดยระบุบริบทเป็นชื่อคลาสนี้
  private readonly logger = new Logger(MassiveApiService.name);
 
  // ตัวแปรเก็บ API Key ของ Finnhub (ถ้าใส่ Key จริง ระบบจะเปลี่ยนไปดึงข้อมูลจริงอัตโนมัติ)
  private readonly apiKey = 'YOUR_API_KEY_HERE';
  // URL หลักของ Finnhub API ที่ใช้สำหรับดึงราคาหุ้นปัจจุบัน (Quote)
  private readonly baseUrl = 'https://finnhub.io/api/v1/quote';
 
  // ฟังก์ชันหลักในการดึงข้อมูลหุ้น รับค่า symbol เช่น 'aapl' หรือ 'tsla'
  async getStockData(symbol: string) {
    // แปลงชื่อสัญลักษณ์หุ้นให้เป็นตัวพิมพ์ใหญ่เสมอ (เช่น 'aapl' -> 'AAPL')
    const uppercaseSymbol = symbol.toUpperCase();
 
    try {
      // ตรวจสอบว่ามีการใส่ API Key จริงแล้วหรือยัง (ไม่ใช่ค่าเริ่มต้น 'YOUR_API_KEY_HERE')
      if (this.apiKey && this.apiKey !== 'YOUR_API_KEY_HERE') {
        // ยิง HTTP GET Request ไปยัง Finnhub API พร้อมส่ง symbol และ token
        const response = await fetch(
          `${this.baseUrl}?symbol=${uppercaseSymbol}&token=${this.apiKey}`,
        );
 
        // ตรวจสอบว่าการร้องขอสำเร็จหรือไม่ (HTTP Status Status 200 OK)
        if (response.ok) {
          // แปลงข้อมูลที่ตอบกลับมาให้เป็น JSON Object
          const data = await response.json();
          // ตรวจสอบว่ามีข้อมูลตอบกลับมาจริง และราคาปัจจุบัน (c = current price) ไม่ใช่ 0
          if (data && data.c !== 0) {
            // แมปข้อมูลจากโครงสร้างของ Finnhub (c, o, h, l, pc, v, dp) เข้ากับฟอร์แมตกลางของระบบเรา
            return {
              symbol: uppercaseSymbol,
              currentPrice: Number(data.c) || 0,   // c = ราคาปัจจุบัน
              open: Number(data.o) || 0,           // o = ราคาเปิดตลาด
              high: Number(data.h) || 0,           // h = ราคาสูงสุดของวัน
              low: Number(data.l) || 0,            // l = ราคาต่ำสุดของวัน
              close: Number(data.pc) || 0,         // pc = ราคาปิดของวันก่อนหน้า (Previous Close)
              volume: Number(data.v) || 1000000,   // v = ปริมาณการซื้อขาย
              percentChange: Number(data.dp) || 0, // dp = เปอร์เซ็นต์การเปลี่ยนแปลงของวัน
            };
          }
        }
      }
 
      // กรณีที่ไม่มี API Key หรือ API ไม่คืนข้อมูล ให้สลับไปใช้ระบบสุ่มข้อมูลจำลอง (Fallback)
      return this.generateMockStockData(uppercaseSymbol);
    } catch {
      // หากเกิด Error ขณะยิง API (เช่น อินเทอร์เน็ตหลุด/Server ล่ม) ให้บันทึก Warning แล้วสลับไปใช้ข้อมูลจำลองแทน
      this.logger.warn(`External API Error for ${symbol}, switching to mock data.`);
      return this.generateMockStockData(uppercaseSymbol);
    }
  }
 
  // ฟังก์ชันส่วนตัว (Private) สำหรับสุ่มตัวเลขทศนิยมช่วง 0 ถึงน้อยกว่า 1 (ใช้แทน Math.random เพื่อให้ปลอดภัยตามมาตรฐาน Sonar)
  private random(): number {
    return randomInt(0, 1_000_000) / 1_000_000;
  }
 
  // ฟังก์ชันส่วนตัว (Private) สำหรับสร้างข้อมูลราคาหุ้นสมจริงสำรองไว้เฉยๆ
  private generateMockStockData(symbol: string) {
    // กำหนดราคาอ้างอิงอสังหาริมทรัพย์/หุ้นตัวดังๆ ไว้ล่วงหน้า
    const basePrices: Record<string, number> = {
      AAPL: 185.50,
      TSLA: 240.20,
      GOOGL: 175.80,
      NVDA: 120.40,
      MSFT: 420.10,
    };
 
    // ดึงราคาอ้างอิงตามชื่อหุ้น หากไม่พบใน Dictionary ให้ใช้ค่าเริ่มต้นคือ 150.0
    const base = basePrices[symbol] || 150.0;
    // สุ่มราคาปัจจุบันให้ผันผวนเล็กน้อยช่วง -2 ถึง +2 จากราคาอ้างอิง (ปัดเศษ 2 ตำแหน่ง)
    const currentPrice = Number((base + (this.random() * 4 - 2)).toFixed(2));
    // สุ่มราคาเปิดตลาดให้ต่างจากราคาปัจจุบันเล็กน้อยช่วง -1 ถึง +1
    const open = Number((currentPrice - (this.random() * 2 - 1)).toFixed(2));
    // คำนวณเปอร์เซ็นต์การเปลี่ยนแปลงระหว่างราคาเปิดกับราคาปัจจุบัน
    const percentChange = Number((((currentPrice - open) / open) * 100).toFixed(2));
 
    // ส่งคืนข้อมูลจำลองในฟอร์แมตเดียวกันกับ API จริง
    return {
      symbol,
      currentPrice,
      open,
      high: Number((Math.max(currentPrice, open) + this.random()).toFixed(2)), // ราคาสูงสุด = ค่ามากสุด + เลขสุ่ม
      low: Number((Math.min(currentPrice, open) - this.random()).toFixed(2)),  // ราคาต่ำสุด = ค่าน้อยสุด - เลขสุ่ม
      close: open,
      volume: Math.floor(this.random() * 50000000) + 10000000,                  // สุ่ม Volume ระหว่าง 10 - 60 ล้าน
      percentChange,
    };
  }
}