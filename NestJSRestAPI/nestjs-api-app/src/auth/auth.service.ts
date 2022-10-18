import { ForbiddenException, Injectable, Req } from "@nestjs/common";
import {User, Note} from '@prisma/client'
import { PrismaService } from "../prisma/prisma.service";
import { AuthDTO } from "./dto";
import * as argon from 'argon2';

@Injectable({})//this is "Dependency Injection"
export class AuthService {
    constructor(private prismaService: PrismaService){
        
    }
    async register(authDTO: AuthDTO){        
        //generate password to hashedPassword
        const hashedPassword = await argon.hash(authDTO.password)
        try {
            //insert data to database
            const user = await this.prismaService.user.create({
                data: {
                    email: authDTO.email,
                    hashedPassword: hashedPassword,
                    firstName: '',
                    lastName: ''
                },
                //only select id, email, createdAt
                select: {
                    id: true,
                    email: true,
                    createdAt: true
                }
            })
            return user
        }catch(error) {            
            if(error.code == 'P2002') {
                //throw new ForbiddenException(error.message)
                //for simple
                throw new ForbiddenException(
                    'User with this email already exists'
                )
            }            
        }
        //you should add constraint "unique" to user table        
        
    }
    async login(authDTO: AuthDTO){        
        //find user with input email
        const user = await this.prismaService
                        .user.findUnique({
                            where: {
                                email: authDTO.email
                            }
                        })
        if(!user) {
            throw new ForbiddenException(
                'User not found'
            )
        }   
        const passwordMatched = await argon.verify(
            user.hashedPassword,
            authDTO.password
        )    
        if(!passwordMatched) {
            throw new ForbiddenException(
                'Incorrect password'
            )
        }        
        delete user.hashedPassword //remove 1 field in the object
        //it doesn't affect to the Database
        return user
        //This is the basic authentication
    }
}