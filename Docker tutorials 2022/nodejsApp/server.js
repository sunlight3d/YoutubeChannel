const ronin = require('ronin-server')
const mocks = require('ronin-mocks')
const server = ronin.server()//expressjs, nestjs

server.use('/', mocks.server(server.Router(), false, true))
const PORT = 8000
console.log(`Server is listening on ${PORT}`)

//destructure environment's object
const {
    MYSQL_HOST, 
    MYSQL_USER, 
    MYSQL_PASSWORD, 
    MYSQL_DB
} = process.env
console.log(`environment's variables: ${JSON.stringify({
    MYSQL_HOST, 
    MYSQL_USER, 
    MYSQL_PASSWORD, 
    MYSQL_DB
})}`)
server.start()  //default port : 8000
//Send request POST:
//You can use Postman
//OR using "terminal"
/*
curl --request POST \
  --url http://localhost:8002/test \
  --header 'content-type: application/json' \
  --data '{"name": "Hoang", "content": "How are you" }'

curl http://localhost:8002/test  

nodemon = node monitor
*/