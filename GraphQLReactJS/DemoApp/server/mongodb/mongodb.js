const mongoose = require('mongoose')
async function connectMongoDB() {
    const connection = await mongoose.connect(process.env.MONGO_URI)
    console.log(`connect MongoDB successfully at ${connection.connection.host}`)
}
module.exports = connectMongoDB