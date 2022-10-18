import { Controller, Post, Req,Body, ParseIntPipe } from "@nestjs/common";
import { AuthService } from "./auth.service";
import { AuthDTO } from './dto'; //import a "folder"
@Controller('auth')
export class AuthController {
    //auth service is automatically created when initializing the controller
    constructor(private authService: AuthService){
        
    }    
    @Post("register",) //register a new user          
    register(@Body() body: AuthDTO) {        
        //not validate using class-validator AND class-transformer
        return this.authService.register();
    }
    //POST: .../auth/login
    @Post("login") 
    login() {
        return this.authService.login();
    }
}
//export = "make public"