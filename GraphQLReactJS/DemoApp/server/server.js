/*

*/
const express = require('express')
const {graphqlHTTP} = require('express-graphql') 
const graphqlSchema = require('./database/schema.js')
const app = express()
require('dotenv').config()
const connectMongoDB = require('./mongodb/mongodb')
connectMongoDB()

const PORT = airocess.env.PORT || 5000
//middleware
app.use('/graphql', graphqlHTTP({
    schema: graphqlSchema,
    //Use Graphic QL if development
    graphiql: process.env.NODE_ENV === 'development'
}))
app.listen(PORT, ()=>{
    console.log(`Listening on port ${PORT}`)
})
