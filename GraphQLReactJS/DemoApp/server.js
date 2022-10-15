/*
 yarn add express express-graphql
 yarn add graphql
 */
import express from 'express'
import dotenv from 'dotenv'
import {graphqlHTTP} from 'express-graphql'
import graphqlSchema from './database/schema'

dotenv.config()
const app = express()
const PORT = process.env.PORT || 5000

//use graphql middleware
app.use('/graphql', graphqlHTTP({
    schema: graphqlSchema,
    graphiql: process.env.NODE_ENV === 'development'
}))
app.listen(PORT, () => {
    console.log('listening on port ' + PORT)
})