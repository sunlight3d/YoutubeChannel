import React from 'react'
import {
    useNavigate, 
    useParams
} from 'react-router-dom'

function Products() {
    const navigate = useNavigate()
    const {productId} = useParams()
    return <div>
        This is Products
        Product's ID is : {productId}
        <button onClick={()=>{
            //alert('click me')
            navigate("/about")
        }}>Navigate to About</button>
    </div>
}
export default Products