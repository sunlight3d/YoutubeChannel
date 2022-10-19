import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { PrismaModule } from '../prisma/prisma.module';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import {JwtStrategy} from './strategy'
//We need to access PrismaService here !
@Module({
    imports: [JwtModule.register({})],    
    controllers: [AuthController],
    providers: [AuthService, JwtStrategy]
})
export class AuthModule {}

