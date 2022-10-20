import { Body, Controller, Get, Patch, Req, UseGuards } from '@nestjs/common';
import { User } from '@prisma/client';
//import { AuthGuard } from '@nestjs/passport';
import {Request} from 'express'
import { GetUser } from '../auth/decorator';
import { MyJwtGuard } from '../auth/guard';
import {UpdateUserDTO } from './dto'
import { UserService } from './user.service';

@Controller('users')
export class UserController {
    constructor(private userService: UserService){}
    //path : .../users/me
    //@UseGuards(AuthGuard('jwt'))
    @UseGuards(MyJwtGuard) //you can also make your own "decorator"
    @Get('me')
    me(@GetUser() user: User){
        //console.log(request.user) //where is it come from ?
        return user        
    }
    @Patch() //PATCH Method
    updateUser(
        @GetUser('id') userId: number,
        @Body() updateUserDTO: UpdateUserDTO
    ){
        this.userService.updateUser(userId, updateUserDTO)
    }
}
