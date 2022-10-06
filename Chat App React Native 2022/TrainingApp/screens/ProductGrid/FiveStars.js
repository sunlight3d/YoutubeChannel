import React, {useState, useEffect} from 'react';
import {
    Text, 
    View,
    Image,
    ImageBackground,
    TouchableOpacity
} from 'react-native'
import {images, colors, icons, fontSizes} from '../../constants'
import Icon from 'react-native-vector-icons/FontAwesome5'

function FiveStars(props) {
    //i
    const {numberOfStars} = props
    return <View style={{
        flexDirection: 'row', justifyContent: 'flex-end'
    }}>
        {[0, 1, 2, 3, 4].map(item => <Icon
            key={`${item}`}
            name='star'
            style={{ marginEnd: 2 }}
            size={8} color={item <= numberOfStars - 1 ? colors.warning : colors.inactive}
        />)}
    </View>
}
export default FiveStars