const {customers, projects}  = require('./fakeData')
const {GraphQLObjectType, GraphQLSchema, GraphQLString, GraphQLID, GraphQLList} = require('graphql')
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
const Project = new GraphQLObjectType({
    name: 'Project',
    fields:() => ({
        projectId: {type: GraphQLID, required: true},
        customerId: { type: GraphQLID },
        name: { type: GraphQLString },
        description: { type: GraphQLString },
        status: { type: GraphQLString },
        //relationship
        customer: {
            type: Customer,
            resolve(parent, args) {
                return customers.find(customer => customer.customerId == parent.customerId)
            }
        }
    })
})

const RootQuery = new GraphQLObjectType({
  name: "RootQuery",
  fields: {
    allCustomers: {
      type: new GraphQLList(Customer),
      resolve(parent, args) {
        return customers;
      },
    },
    customer: {
      type: Customer, //return type of this query
      args: { id: { type: GraphQLID } }, //arguments
      resolve(parent, args) {
        const foundCustomer = customers.find(
          (customer) => customer.customerId == args.id
        );
        console.log(`foundCustomer: ${JSON.stringify(foundCustomer)}`);
        return foundCustomer;
      },
    },
    allProjects: {
      type: new GraphQLList(Project),
      resolve(parent, args) {
        return projects;
      },
    },
    project: {
      type: Project, //return type of this query
      args: { id: { type: GraphQLID } }, //arguments
      resolve(parent, args) {        
        return projects.find(
            (project) => project.projectId == args.id
        )
      },
    },
  },
});
module.exports = new GraphQLSchema({
    query: RootQuery
})
