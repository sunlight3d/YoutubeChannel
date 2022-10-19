import { Injectable } from "@nestjs/common";
import { ConfigService } from "@nestjs/config";
import { PassportStrategy } from "@nestjs/passport";
import { ExtractJwt, Strategy } from "passport-jwt";
import { PrismaService } from "../../prisma/prisma.service";

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy, 'jwt') {
  constructor(
    configService: ConfigService,
    public prismaService: PrismaService) {
    super({
        //token string is added to every request(except login / register)
        jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),      
        secretOrKey: configService.get('JWT_SECRET')
    });
  }
  async validate(payload: {sub: number; email: string}) {        
    const user = await this.prismaService.user.findUnique({
        where: {
            id: payload.sub
        }
    })
    delete user.hashedPassword
    return user;
  }
}


