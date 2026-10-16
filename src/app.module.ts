import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';

import { PriceAlertModule } from './price-alert/stock-price.module';
import { SmaModule } from './sma/sma.module';
import { StockComparisonModule } from './stock-comparison/stocks.module';
import { MoversModule } from './modules/movers/movers.module';
import { ConditionalOrdersModule } from './conditional-orders/conditional-orders.module';
import { CalendarModule } from './calendar/calendar.module';
import { WatchlistModule } from './watchlist/watchlist.module';
import { StockScreenerModule } from './stock-screener/stock-screener.module';
import { StockModule } from './RecoveryStock/src/stock/stock.module';
import { BacktestingModule } from './backtesting/backtesting/backtesting.module';

@Module({
  imports: [
    // โหลดไฟล์ .env และใช้งานได้ทั้งโปรเจกต์
    ConfigModule.forRoot({ 
      isGlobal: true 
    }),

    // ตั้งค่าเชื่อมต่อ PostgreSQL แบบ Dynamic Async
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => ({
        type: 'postgres',
        host: configService.get<string>('DB_HOST', 'localhost'),
        port: configService.get<number>('DB_PORT', 5432),
        username: configService.get<string>('DB_USERNAME', 'postgres'),
        password: configService.get<string>('DB_PASSWORD', 'yuki134818'),
        database: configService.get<string>('DB_NAME', 'price_alert_stocks'),
        
        // ดึง Entities จากทุก Module ในโปรเจกต์อัตโนมัติ
        autoLoadEntities: true, 
        
        // สั่งให้สร้าง/ปรับโครงสร้างตาราง DB อัตโนมัติตาม Entity เมื่อย้ายเครื่อง
        synchronize: true, 
      }),
    }),

    // รวม Feature Modules ทั้งหมดของระบบ
    PriceAlertModule,
    StockComparisonModule,
    MoversModule,
    ConditionalOrdersModule,
    CalendarModule,
    WatchlistModule,
    BacktestingModule,
    StockScreenerModule,
    SmaModule,
    StockModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}