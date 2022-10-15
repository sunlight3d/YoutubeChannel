const {customers, projects}  = require('./fakeData')
const {GraphQLObjectType, GraphQLSchema, GraphQLString, GraphQLID} = require('graphql')
const Customer = new GraphQLObjectType({
    name: 'Customer',
    fields:() => ({
        customerId: {type: GraphQLID, required: true},
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
                const foundCustomer = customers.find(customer => customer.customerId == args.id)
                console.log(`foundCustomer: ${JSON.stringify(foundCustomer)}`)
                return foundCustomer
            }
       } 
    }
})
module.exports = new GraphQLSchema({
    query: CustomerQuery
})
