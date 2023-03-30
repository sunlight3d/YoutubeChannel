import {Student} from '../../models/index.js'
import studentRepository from '../../repositories/student.js'

describe('Some CRUD test', () => {
    it('Test number of students', async () => {
        debugger 
        let students = await studentRepository.getAllStudents({
            page: 1,
            size: 20,
            searchString: ''
        })
        //
    })
})