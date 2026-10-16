CREATE TABLE IF NOT EXISTS trade_records (
    id SERIAL PRIMARY KEY,
    "symbol" VARCHAR(20) NOT NULL,
    "timeframe" VARCHAR(20) NOT NULL,
    "initialCapital" FLOAT NOT NULL,
    "finalBalance" FLOAT NOT NULL,
    "profit" FLOAT NOT NULL,
    "winRate" FLOAT NOT NULL,
    "status" VARCHAR(20) NOT NULL,
    "createdAt" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO trade_records ("symbol", "timeframe", "initialCapital", "finalBalance", "profit", "winRate", "status")
VALUES
('BTCUSDT', '1d', 10000.00, 25000.00, 15000.00, 65.50, 'PROFIT'),
('ETHUSDT', '4h', 10000.00, 6500.00, -3500.00, 42.00, 'LOSS');