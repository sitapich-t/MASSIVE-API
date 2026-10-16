import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class CreateTradeRecordTables1730000000001 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'trade_records',
        columns: [
          {
            name: 'id',
            type: 'int',
            isPrimary: true,
            isGenerated: true,
            generationStrategy: 'increment',
          },
          { name: 'symbol', type: 'varchar', length: '20' },
          { name: 'timeframe', type: 'varchar', length: '20' },
          { name: 'initialCapital', type: 'float' },
          { name: 'finalBalance', type: 'float' },
          { name: 'profit', type: 'float', isNullable: true }, // เพิ่ม isNullable ป้องกัน DB พังถ้าไม่ได้ส่งค่า
          { name: 'winRate', type: 'float', isNullable: true }, // เพิ่ม isNullable
          { name: 'status', type: 'varchar', length: '20', isNullable: true }, //  เพิ่ม isNullable
          { name: 'createdAt', type: 'timestamp', default: 'now()' },
        ],
      }),
      true,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('trade_records');
  }
}