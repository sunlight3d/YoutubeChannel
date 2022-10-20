import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
//like Express ? Yes
/**
 How to generate a module:
 nest g module "module name"
 We have 2 entities: User and Note, 1 User can write many Notes
 -controller is where to receive request from client
 -controller will call services to do implementations
 Prisma = dependency which connect to dB using ORM(Object Relational Mapping)
 Now add a module named "prisma"

 */
async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  //add middleware HERE !
  app.enableCors();
  app.useGlobalPipes(new ValidationPipe({
    whitelist: true,
  }));
  await app.listen(3002);
}
bootstrap();
