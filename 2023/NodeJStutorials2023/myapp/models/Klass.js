import { ObjectId, Schema } from "mongoose"
import mongoose from "mongoose"
const Klass = mongoose.model('Klass', 
    new Schema({
        id: {type: ObjectId},
        name: { 
            type: String, 
            required: true,
            //model validation
            validate: {
                validator: () => this.name.length > 3,
                message: `Class's name must be at least 4 characters.Eg: C2110I`
            }        
        },                        
    })
)
export default Klass