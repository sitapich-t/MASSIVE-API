import { HttpException, HttpStatus } from '@nestjs/common';

export class DbExecutionException extends HttpException {
  constructor(message = 'Database execution failed') {
    super(
      {
        statusCode: HttpStatus.INTERNAL_SERVER_ERROR,
        error: 'DATABASE_ERROR',
        message,
      },
      HttpStatus.INTERNAL_SERVER_ERROR,
    );
  }
}