import { Injectable, BadRequestException } from '@nestjs/common';

@Injectable()
export class StocksService {
  private async fetchHistoricalPrices(symbol: string, timeframe: string): Promise<{ date: string; price: number }[]> {
    // 1. แปลงค่า timeframe ของระบบ ให้เป็นพารามิเตอร์ range ที่ Yahoo Finance รองรับ
    let range = '7d';
    if (timeframe === '1d') range = '1d';   // ดึงข้อมูล 1 วัน
    if (timeframe === '30d') range = '1mo'; // 30 วัน ใช้ 1mo (1 month)
    if (timeframe === '1y') range = '1y';   // ดึงข้อมูล 1 ปี

    // สร้าง URL สำหรับขอข้อมูลกราฟราคาปิดรายวัน (interval=1d)
    const url = `https://query2.finance.yahoo.com/v8/finance/chart/${symbol}?range=${range}&interval=1d`;

    try {
      // 2. ยิง HTTP GET Request พร้อมจำลอง User-Agent ของ Web Browser เพื่อป้องกันโดน Yahoo ปล็อก
      const response = await fetch(url, {
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
          'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
          'Accept-Language': 'en-US,en;q=0.9',
        },
      });

      // หากสถานะการเชื่อมต่อไม่ปกติ ให้ส่งข้อผิดพลาดออกไป
      if (!response.ok) {
        throw new BadRequestException(`ไม่สามารถดึงข้อมูลหุ้น ${symbol} ได้`);
      }

      const data = await response.json();
      const result = data.chart?.result?.[0];

      // ตรวจสอบความถูกต้องของโครงสร้าง JSON ว่ามี timestamp ส่งกลับมาจริงหรือไม่
      if (!result?.timestamp) {
        throw new BadRequestException(`ไม่พบข้อมูลราคาสำหรับ ${symbol}`);
      }

      // ดึงอาร์เรย์ของเวลา (timestamps) และราคาปิด (closes)
      const timestamps: number[] = result.timestamp || [];
      const closes: (number | null)[] = result.indicators?.quote?.[0]?.close || [];

      const historicalData: { date: string; price: number }[] = [];

      // 3. วนลูปจับคู่ Timestamp เข้ากับราคาปิด
      timestamps.forEach((ts, index) => {
        const price = closes[index];

        // คัดกรองเอาเฉพาะวันที่มีราคาปิดจริง (ข้ามวันหยุดทำการที่ราคาเป็น null)
        if (price !== null && price !== undefined) {
          // จัดฟอร์แมตวันที่: ถ้าเป็น 1y ให้แสดง เดือน+ปี (เช่น Jan 25) ถ้าเป็นช่วงอื่นให้แสดง เดือน+วัน (เช่น Sep 18)
          const dateOptions: Intl.DateTimeFormatOptions = timeframe === '1y' 
            ? { month: 'short', year: '2-digit' }
            : { month: 'short', day: 'numeric' };

          // แปลง Unix Timestamp (วินาที) ให้เป็นวันที่รูปแบบข้อความภาษาอังกฤษ
          const dateStr = new Date(ts * 1000).toLocaleDateString('en-US', dateOptions);
          historicalData.push({ date: dateStr, price });
        }
      });

      // หากไม่มีข้อมูลราคาปิดหลงเหลืออยู่เลย ให้โยน Exception
      if (historicalData.length === 0) {
        throw new BadRequestException(`ไม่มีข้อมูลราคาปิดสำหรับ ${symbol}`);
      }

      // 4. กรณีเลือก 1d: ให้ตัดเลือกเฉพาะ 2 วันล่าสุด (วันเมื่อวาน + วันนี้) เพื่อใช้เมื่อวานเป็นฐาน 0% ในการวัดผลตอบแทนวันนี้
      if (timeframe === '1d') {
        return historicalData.slice(-2);
      }

      return historicalData;
    } catch {
      throw new BadRequestException(`ไม่พบข้อมูลหุ้นสัญลักษณ์: ${symbol}`);
    }
  }

  /**
   * คำนวณค่าสหสัมพันธ์ (Pearson Correlation Coefficient) ระหว่างชุดข้อมูลผลตอบแทนหุ้น 2 ตัว
   * คืนค่าระหว่าง -1.0 (วิ่งตรงข้ามกัน) ถึง +1.0 (วิ่งไปทางเดียวกัน)
   */
  private calculateCorrelation(x: number[], y: number[]): number {
    // หาความยาวข้อมูลขั้นต่ำที่ตรงกัน
    const n = Math.min(x.length, y.length);
    if (n === 0) return 0;

    // 1. หาค่าเฉลี่ย (Mean) ของชุดข้อมูลทั้งสอง
    const meanX = x.reduce((a, b) => a + b, 0) / n;
    const meanY = y.reduce((a, b) => a + b, 0) / n;

    let num = 0;   // ตัวเศษ: ผลรวมของความเบี่ยงเบน (dx * dy)
    let denX = 0;  // ตัวส่วน X: ผลรวมของความเบี่ยงเบนกำลังสอง (dx^2)
    let denY = 0;  // ตัวส่วน Y: ผลรวมของความเบี่ยงเบนกำลังสอง (dy^2)

    // 2. วนลูปคำนวณตามสูตร Pearson Correlation
    for (let i = 0; i < n; i++) {
      const dx = x[i] - meanX;
      const dy = y[i] - meanY;
      num += dx * dy;
      denX += dx * dx;
      denY += dy * dy;
    }

    // 3. คำนวณตัวส่วนรวม = sqrt(denX * denY)
    const denominator = Math.sqrt(denX * denY);

    // ป้องกันการหารด้วย 0 (กรณีราคามีค่าเท่าเดิมตลอด) และปัดเศษทศนิยม 4 ตำแหน่ง
    return denominator === 0 ? 0 : Number((num / denominator).toFixed(4));
  }

  /**
   * ฟังก์ชันหลัก: ดึงข้อมูล คำนวณ % Return สะสม และคำนวณ Correlation สำหรับส่งให้ Controller
   */
  async compareStocks(stock1: string, stock2: string, timeframe: string = '7d') {
    // ทำความสะอาดและแปลงสัญลักษณ์หุ้นเป็นตัวพิมพ์ใหญ่
    const s1 = stock1.toUpperCase().trim();
    const s2 = stock2.toUpperCase().trim();

    // 1. ดึงราคาย้อนหลังของหุ้นทั้งคู่พร้อมกันแบบ Parallel ด้วย Promise.all เพื่อเพิ่มความเร็ว
    const [data1, data2] = await Promise.all([
      this.fetchHistoricalPrices(s1, timeframe),
      this.fetchHistoricalPrices(s2, timeframe),
    ]);

    // 2. ปรับความยาวของข้อมูลทั้งคู่ให้เท่ากัน ยึดตามชุดข้อมูลที่มีวันน้อยกว่า
    const minLength = Math.min(data1.length, data2.length);
    const sliced1 = data1.slice(-minLength);
    const sliced2 = data2.slice(-minLength);

    // 3. กำหนดราคาวันแรกสุดในชุดข้อมูลเป็นราคาตั้งต้น (Base Price = 0%)
    const basePrice1 = sliced1[0].price;
    const basePrice2 = sliced2[0].price;

    const stock1Returns: number[] = [];
    const stock2Returns: number[] = [];

    // 4. วนลูปคำนวณเปอร์เซ็นต์ผลตอบแทนสะสมเทียบกับวันแรก
    const chartData = sliced1.map((item, index) => {
      const p1 = item.price;
      const p2 = sliced2[index].price;

      // สูตรการหา % Return: ((ราคาปัจจุบัน - ราคาตั้งต้น) / ราคาตั้งต้น) * 100
      const ret1 = Number((((p1 - basePrice1) / basePrice1) * 100).toFixed(2));
      const ret2 = Number((((p2 - basePrice2) / basePrice2) * 100).toFixed(2));

      // บันทึกค่า Return ลงอาร์เรย์เพื่อนำไปคำนวณ Correlation ต่อ
      stock1Returns.push(ret1);
      stock2Returns.push(ret2);

      return {
        label: item.date,
        [`${s1}_return`]: ret1,
        [`${s2}_return`]: ret2,
      };
    });

    // 5. คำนวณค่าสหสัมพันธ์ระหว่างผลตอบแทนหุ้นทั้งสองตัว
    const correlationCoefficient = this.calculateCorrelation(stock1Returns, stock2Returns);

    // 6. ส่งผลลัพธ์กลับไปหา Controller
    return {
      success: true,
      stock1: { symbol: s1 },
      stock2: { symbol: s2 },
      timeframe,
      correlationCoefficient,
      chartData,
    };
  }
}