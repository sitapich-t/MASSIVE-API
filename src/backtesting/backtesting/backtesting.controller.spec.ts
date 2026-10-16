import { Test, TestingModule } from '@nestjs/testing';
import { BacktestingController } from './backtesting.controller';
import { BacktestingService } from './backtesting.service';

describe('BacktestingController', () => {
  let controller: BacktestingController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [BacktestingController],
      providers: [
        {
          provide: BacktestingService,
          useValue: { simulate: jest.fn() },
        },
      ],
    }).compile();

    controller = module.get<BacktestingController>(BacktestingController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});