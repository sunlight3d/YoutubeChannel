import {customers, projects} from './fakeData'
import {GraphQLID, GraphQLObjectType, GraphQLSchema} from 'graphql'

const Customer = new GraphQLObjectType({
    name: 'Customer',
    fields: () => ({
        customerId: { type: GraphQLID },
        customerName: { type: GraphQLString },
        email: { type: GraphQLString },
        address: { type: GraphQLString },
        country: { type: GraphQLString },
    })
})
const CustomerQuery = new GraphQLObjectType({
    name: 'CustomerQuery',
    fields: {
        customer: {
            type: Customer,//return type of this query
            args: {id: { type: GraphQLID}}, //arguments
            resolve(parent, args) {
                return customers.find(eachCustomer => eachCustomer.id === args.id)
            }
       } 
    }
})
export default new GraphQLSchema({
    query: CustomerQuery
})
