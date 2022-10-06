
import {
    Platform,
    Dimensions,
} from 'react-native'
export const isIOS = () => Platform.OS === 'ios'
export const screenWidth = Dimensions.get("screen").width;
export const screenHeight = Dimensions.get("screen").height;