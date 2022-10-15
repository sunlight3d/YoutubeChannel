//There are 2 entities:
const customers = [
    {
        customerId: 1,
        customerName: 'Alfreds Futterkiste',
        email: 'AlfredsFutterkiste@gmail.com',
        address: 'Obere Str. 57',
        country: 'Germany'
    },
    {
        customerId: 2,
        customerName: 'Thomas Hardy',
        email: 'ThomasHardy@gmail.com',
        address: '120 Hanover Sq.',
        country: 'UK'
    },
    {
        customerId: 3,
        customerName: 'Familia Arquibaldo',
        email: 'FamiliaArquibaldo@yahoo.com',
        address: 'Rua Orós, 92',
        country: 'Brazil'
    }
]
//1 customer owns many projects
const projects = [
    {
        projectId: 1,
        customerId: 1,
        name: 'Health ios App',
        description: 'This is an App written in Swift, has > 10 screens',
        status: "in progress"
    },
    {
        projectId: 2,
        customerId: 2,
        name: 'Ecommerce Website',
        description: 'Ecommerce website using PHP Laravel 10',
        status: "done"
    },
    {
        projectId: 3,
        customerId: 1,
        name: 'Dating App',
        description: 'Multi platform App with Flutter or React Native',
        status: "do not start yet"
    },
]
module.exports = {
    customers, 
    projects
}