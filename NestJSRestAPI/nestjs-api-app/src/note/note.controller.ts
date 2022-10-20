import { 
    Body, Controller, 
    Get, Patch, Req, UseGuards,
    Post, Delete, Param 
} from '@nestjs/common'
import { GetUser } from '../auth/decorator'
import { MyJwtGuard } from '../auth/guard'
import { NoteService } from './note.service'
import { InsertNoteDTO } from './dto'
import { UpdateNoteDTO } from './dto/update.note.dto';
import { ParseIntPipe } from '@nestjs/common';

@UseGuards(MyJwtGuard)
@Controller('notes')
export class NoteController {
    constructor(private noteService: NoteService) {}
    @Get()
    getNotes(@GetUser('id') userId: number) {
        return this.noteService.getNotes(userId)
    }
    @Get(':id')//example: /notes/123
    getNoteById(@Param('id') noteId: number) {
        return this.noteService.getNoteById(noteId)
    }
    @Post()
    insertNote(
        @GetUser('id') userId: number,
        @Body() insertNoteDTO: InsertNoteDTO
    ){
        return this.noteService.insertNote(userId, insertNoteDTO)
    }
    @Patch()
    updateNoteById(
        @Param('id', ParseIntPipe) noteId: number, //validate noteId is "number"
        @Body() updateNoteDTO: UpdateNoteDTO
    ) {
        return this.noteService.updateNoteById(noteId, updateNoteDTO)
    }
    @Delete()
    deleteNoteById(@Param('id', ParseIntPipe) noteId: number){
        return this.deleteNoteById(noteId)
    }
    //Now we test this API using POSTMAN first !
}

