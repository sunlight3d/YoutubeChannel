import React, {useState, useEffect} from 'react';
import {
    Text, 
    View,
    Image,
    TouchableOpacity,
    TextInput,    
    FlatList
} from 'react-native'
import {images, colors, icons, fontSizes} from '../../constants'
import Icon from 'react-native-vector-icons/FontAwesome5'
import FiveStars from './FiveStars';
function GridItem(props) {
    const {item, index, onPress} = props
    return <View style={{
        flex: 0.5,
        //height: 200,
        marginLeft: index % 2 == 0 ? 10 : 0,
        marginTop: 5,
        marginRight: 10,
        marginBottom: 5,
        borderRadius: 20,
        borderWidth: 1,
        borderColor: colors.inactive
    }}>
        <View style={{
            flexDirection: 'row',
            marginTop: 10,
            marginHorizontal: 5
        }}>
            <Image
                style={{
                    width: 70,
                    height: 90,
                    resizeMode: 'cover',
                    borderRadius: 20,
                    marginRight: 15
                }}
                source={{
                    uri: item.url
                }} />
            <Text style={{
                color: 'black',
                fontSize: fontSizes.h3,
                flex: 1,
                textAlign: 'right'
            }}>$ {item.price}</Text>
        </View>
        <Text style={{
            color: colors.primary,
            fontWeight: 'bold',
            fontSize: fontSizes.h6,
            marginHorizontal: 10,
            marginTop: 5,
        }}>$ {item.productName}
        </Text>
        {
            item.specifications.map(specification =>
                <Text
                    key={specification}
                    style={{
                        color: 'black',
                        fontSize: fontSizes.h6,
                        paddingHorizontal: 10,
                        paddingBottom: 10,

                    }}>* {specification}</Text>)
        }
        <View style={{ flexDirection: 'row', padding: 10 }}>
            <TouchableOpacity
                onPress={onPress}
                style={{ flexDirection: 'row' }}>
                <Icon
                    name='heart'
                    style={{ marginEnd: 5 }}
                    size={22} color={
                        item.isSaved == undefined || item.isSaved == false ?
                            colors.inactive : 'red'} />
                <Text style={{
                    color: item.isSaved == undefined || item.isSaved == false ?
                        colors.inactive : 'red',
                    fontSize: fontSizes.h6 * 0.8,
                    width: 50
                }}>Saved for later</Text>
            </TouchableOpacity>
            <View style={{
                flex: 1,
            }}>
                <FiveStars numberOfStars={item.stars} />
                <Text style={{
                    color: colors.success,
                    fontSize: fontSizes.h6 * 0.8,
                    textAlign: 'right',
                    paddingTop: 5
                }}>{item.reviews} reviews</Text>
            </View>
        </View>
    </View>
}
export default GridItem