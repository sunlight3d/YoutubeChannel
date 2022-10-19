//make a database for testing !
//Everytime we run tests, clean up data
//We must call request like we do with Postman
/**
 How to open prisma studio on "TEST" database ?
 npx dotenv -e .env.test -- prisma studio
 How to open prisma studio on "DEV" database ?
 npx dotenv -e .env -- prisma studio
 */
import {Test} from '@nestjs/testing'
import { AppModule } from '../src/app.module';
import { INestApplication, ValidationPipe } from '@nestjs/common';
describe('App EndToEnd tests', () => {
  let app: INestApplication
  beforeAll(async () => {
    const appModule = await Test.createTestingModule({
      imports: [AppModule]
    }).compile()
    app = appModule.createNestApplication()
    app.useGlobalPipes(new ValidationPipe())
    await app.init()
  })
  afterAll(async () =>{
    app.close()
  })
  it.todo('should PASS, haha 1');
  it.todo('should PASS, haha 2');
})