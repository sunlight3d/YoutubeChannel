import { Module } from '@nestjs/common';
import { PrismaModule } from '../prisma/prisma.module';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
//We need to access PrismaService here !
@Module({
    imports: [PrismaModule],
    controllers: [AuthController],
    providers: [AuthService]
})
export class AuthModule {}

