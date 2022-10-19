import { Controller, Get, Req, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import {Request} from 'express'

@Controller('users')
export class UserController {
    //path : .../users/me
    @UseGuards(AuthGuard('jwt'))
    @Get('me')
    me(@Req() request: Request){
        //console.log(request.user) //where is it come from ?
        return request.user
    }
}
