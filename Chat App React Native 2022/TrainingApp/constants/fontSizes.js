import {isIOS} from '../utilies/Device'
export default {
    h1: isIOS() ? 24 : 22,
    h2: isIOS() ? 22 : 20,
    h3: isIOS() ? 20 : 18,
    h5: isIOS() ? 16 : 14,
    h6: isIOS() ? 14 : 12,
}