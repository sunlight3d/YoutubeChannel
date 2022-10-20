import { IsOptional, IsString } from "class-validator";

export class UpdateUserDTO {
    @IsString()
    @IsOptional()
    firstName?: string

    @IsString()
    @IsOptional()
    lastName?: string
}