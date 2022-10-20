import { IsNotEmpty, IsOptional, IsString } from "class-validator"

export class InsertNoteDTO {
    @IsString()
    @IsNotEmpty()
    title: string

    @IsString()
    @IsNotEmpty()
    description: string
    
    @IsString()
    @IsNotEmpty()
    url: string
}