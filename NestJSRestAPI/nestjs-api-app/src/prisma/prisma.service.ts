import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PrismaClient } from '@prisma/client';

@Injectable()
//This service is used to connect DB
export class PrismaService extends PrismaClient{
    constructor(configService: ConfigService){
        super({
            datasources: {
                db:{
                    //we need to secure this !
                    //url: 'postgresql://postgres:Abc123456789@localhost:5434/testdb?schema=public'
                    url: configService.get('DATABASE_URL')                    
                }
            }
        })
        console.log('db url :'+configService.get('DATABASE_URL'))
    }
    cleanDatabase(){
        //In a 1 - N relation, delete N firstly, then delete "1"
        console.log('cleanDatabase')
        return this.$transaction([
            //2 commands in ONE transaction
            this.note.deleteMany(),
            this.user.deleteMany()
        ])
        
    }
}
