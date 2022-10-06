import React, {useState, useEffect} from 'react';
import {
    Text, 
    View, 
    FlatList,
    SafeAreaView
} from 'react-native'
//import { SafeAreaView } from 'react-native-safe-area-context';
import GridItem from './GridItem';
function ProductGridView(props) {
    const [products, setProducts] = useState([
        {
            productName: 'Samsung SC 5573',
            url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJ_RmmJwasIPHbPZ64WpqRYGw-oNHxhL_k7_wdwronrgS_kSy2eDjv1llYolxWb_NqTOI&usqp=CAU',
            price: 75,            
            specifications: [
                'Dry clean', 
                'cyclone filter',
                'convenience cord storage'
            ],
            reviews: 19,
            stars: 5,            
        },
        {
            productName: 'AirRam Cordless Stick Vacuum Cleaner',
            url: 'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1629751832-GUEST_48042c13-4bd6-4867-abe0-879066c14938.jpg?crop=1xw:1.00xh;center,top&resize=768:*',
            price: 88,            
            specifications: [
                'Slim design', 
                'Easy to maneuver',
                'Stands upright for storage'
            ],
            reviews: 120,
            stars: 4,
        },
        {
            productName: 'Complete C3 Vacuum for Soft Carpet',
            url: 'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1628695630-miele-complete-c3-vacuum-for-soft-carpet-1628695621.jpg?crop=1xw:1xh;center,top&resize=768:*',
            price: 98,            
            specifications: [
                'Complete C3 Vacuum for', 
                'Excellent filtration',                
            ],
            reviews: 146,
            stars: 3,
        },
        {
            productName: '1800W Ease C4 bagless canister vacuum cleaner',
            url: 'https://www.electrolux.vn/globalassets/vn-product-images/vacuum-cleaner/ec31-2bb-1500x1500-min.png?preset=medium',
            price: 993.3,            
            specifications: [
                'Solid construction', 
                'Excellent filtration',
                'Works on all carpet heights and densities',
                'Heavy'
            ],
            reviews: 546,
            stars: 1,
        },
        {
            productName: 'Roomba s9+ Robot Vacuum',
            url: 'https://www.electrolux.vn/remote.jpg.ashx?urlb64=aHR0cHM6Ly93d3cuZWxlY3Ryb2x1eC5pbS9wcm9kdWN0cy9YTUxMQVJHRVJJTUFHRS9aOTMxLTcwMC5wbmc&hmac=4jenSHJSWAc&preset=medium',
            price: 1099,            
            specifications: [
                'Fully featured robot vacuum', 
                "Doesn't clog with pet hair",
                "Automatically empties dirt into its bin"
            ],
            reviews: 66,
            stars: 5,
        },
        {
            productName: '20V Cordless Cube Compact Vacuum Cleaner',
            url: 'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1621533694-410taraVerL._SL500_.jpg?crop=1xw:1.00xh;center,top&resize=768:*',
            price: 88,            
            specifications: [
                'Rinsable HEPA filter', 
                'Three-year warranty',                
            ],
            reviews: 698,
            stars: 3,
        },
        {
            productName: 'S7 Robot Vacuum and Mop Cleaner',
            url: 'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1629754591-414prpgboLL._SL500_.jpg?crop=1xw:0.972xh;center,top&resize=768:*',
            price: 659.33,            
            specifications: [
                'Vacuums and mops in a single session', 
                'Comes in white and black',
                'App is easy to download and use',
                'Works by voice commands',
            ],
            reviews: 223,
            stars: 1,
        },
        {
            productName: 'V15 Detect Cordless Vacuum',
            url: 'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1635541875-31B4xOxdtNS._SL500_.jpg?crop=1xw:1.00xh;center,top&resize=768:*',
            price: 188,            
            specifications: [
                'Automatically adjusts speed and suction', 
                'Laser spotter makes it easier to see dust on bare floors',                
            ],
            reviews: 325,
            stars: 3,
        },
        {
            productName: 'Pure C9 bagless vacuum cleaner',
            url: 'https://www.electrolux.vn/globalassets/d2c-vn/vacuum-cleaners/vn-pc91-5ibm-1500x1500-min.png?preset=small',
            price: 112,            
            specifications: [
                'Cash on delivery accepted', 
                ' Free installation',
                ' 2 years warranty'
            ],
            reviews: 232,
            stars: 2,
        },
        {
            productName: '25V ErgoRapido bagless handstick vacuum cleaner',
            url: 'https://www.electrolux.vn/globalassets/d2c-vn/vacuum-cleaners/vn-zb3314ak-1500x1500-min.png?preset=medium',
            price: 188,            
            specifications: [
                'BrushRollClean means no more manual cleaning', 
                '45 minutes* run-time for quick or deep cleaning',
                '2-in-1 handheld for cleaning hard-to-reach areas'
            ],
            reviews: 321,
            stars: 3,
        },
        {
            productName: '2000W Ease C4 bagless canister vacuum cleaner',
            url: 'https://www.electrolux.vn/globalassets/vn-product-images/vacuum-cleaner/ec41-6cr-1500x1500-min.png?preset=medium',            
            specifications: [
                'Large rotary wheels for increased stability.', 
                'High-capacity 1.8 liter dust canister.',
                'Designed for easy emptying with single button release'
            ],
            price: 253.35,            
            reviews: 12,
            stars: 1,
        }
    ])
    return <SafeAreaView style={{
        flex: 1,
        backgroundColor: 'white'
    }}>
        <FlatList 
            style={{marginTop: 5}}        
            data={products}
            numColumns={2}
            keyExtractor={item => item.productName}
            renderItem={({item, index}) => <GridItem 
                item={item} index={index}
                onPress={() => {
                    let clonedProducts = products.map(eachProduct => {
                        if (item.productName == eachProduct.productName) {
                            //return {...eachProduct, isSaved: true}
                            return {
                                ...eachProduct,
                                isSaved: eachProduct.isSaved == false
                                    || eachProduct.isSaved == undefined
                                    ? true : false
                            }
                        }
                        return eachProduct
                    })
                    setProducts(clonedProducts)   
                }}
                />}
            />
    </SafeAreaView>
}
export default ProductGridView