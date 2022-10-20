import {Injectable} from '@nestjs/common'
import { InsertNoteDTO, UpdateNoteDTO } from './dto';

@Injectable()
export class NoteService {
    getNotes(userId: number) {

    }
    getNoteById(noteId: number) {

    }
    insertNote(
        userId: number,
        insertNoteDTO: InsertNoteDTO
    ){

    }
    updateNoteById(
        noteId: number,
        updateNoteDTO: UpdateNoteDTO
    ) {

    }
    deleteNoteById(noteId: number){

    }
}