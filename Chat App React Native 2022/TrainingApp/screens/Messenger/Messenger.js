import React, {useState, useEffect} from 'react';
import {
    Text, 
    View,
    Image,
    ImageBackground,
    TouchableOpacity,
    FlatList,
    Keyboard,
} from 'react-native'
import {images, colors, icons, fontSizes} from '../../constants'
import Icon from 'react-native-vector-icons/FontAwesome5'
import { UIHeader } from '../../components'
import MessengerItem from './MessengerItem'
import { TextInput } from 'react-native-gesture-handler';
import AsyncStorage from '@react-native-async-storage/async-storage'
import {
    auth,
    onAuthStateChanged,
    firebaseDatabaseRef,
    firebaseSet,
    firebaseDatabase
} from '../../firebase/firebase'

function Messenger(props) {
    const [typedText, setTypedText] = useState('')
    const [chatHistory, setChatHistory] = useState([
        {
           url: 'https://randomuser.me/api/portraits/men/70.jpg',
           showUrl: true,
           isSender: true,           
           messenger: "Hello",
           timestamp: 1641654238000,
        },
        {
            url: 'https://randomuser.me/api/portraits/men/70.jpg',
            showUrl: false,
            isSender: true,
            messenger: "How are you ?",
            timestamp: 1641654298000,
         },
         {             
            url: 'https://randomuser.me/api/portraits/men/70.jpg',
            showUrl: false,
            isSender: true,
            messenger: "How about your work ?. nujdhsfuhduf dhuhu uhuh uhfudhufduhu hufhfd",
            timestamp: 1641654538000,
         },
         {
            url: 'https://randomuser.me/api/portraits/men/50.jpg',
            showUrl: true,
            isSender: false,
            messenger: "Yes",
            timestamp: 1641654598000,
         },
         {
            url: 'https://randomuser.me/api/portraits/men/50.jpg',
            showUrl: false,
            isSender: false,
            messenger: "I am fine",
            timestamp: 1641654598000,
         },
         {
            url: 'https://randomuser.me/api/portraits/men/70.jpg',
            showUrl: true,
            isSender: true,
            messenger: "Let's go out",
            timestamp: 1641654778000,
         },
    ])    
    const {url, name, userId} = props.route.params.user
    const {navigate, goBack} = props.navigation
    return <View style={{
        flexDirection: 'column',
        flex: 1,
    }}>        
        <UIHeader 
            title={name} 
            leftIconName={"arrow-left"}
            rightIconName={"ellipsis-v"}
            onPressLeftIcon={()=>{
                goBack()
            }}
            onPressRightIcon={()=>{
                alert('press right icon')
            }}
        />
        
        <FlatList style={{    
            flex: 1,
        }} 
        data={chatHistory}
        renderItem={({item}) => <MessengerItem             
            onPress={()=> {                        
                alert(`You press item's name: ${item.timestamp}`)
            }}
            item = {item} key={`${item.timestamp}`}/>}            
        />
        <View style={{
            height: 50,            
            position: 'absolute',
            bottom: 0,
            left: 0,
            right: 0,
            flexDirection: 'row',
            justifyContent: 'space-between',
            alignItems: 'center',
        }}>
            <TextInput
                onChangeText={(typedText) => {
                    setTypedText(typedText)
                }}
                style={{
                    color: 'black',
                    paddingStart: 10,
                }}
                placeholder='Enter your message here'
                value={typedText}
                placeholderTextColor={colors.placeholder}
            />
            <TouchableOpacity onPress={async ()=>{
                if(typedText.trim().length == 0) {
                    return
                }                
                 debugger
                 let stringUser = await AsyncStorage.getItem("user")
                 let myUserId = JSON.parse(stringUser).userId
                 let myFriendUserId = props.route.params.user.userId
                 //save to Firebase DB
                 let newMessengerObject = {
                    //fake
                    url: 'https://randomuser.me/api/portraits/men/50.jpg',
                    showUrl: false,                    
                    messenger: typedText,
                    timestamp: (new Date()).getTime(),
                 } 
                 Keyboard.dismiss()                
                 firebaseSet(firebaseDatabaseRef(
                    firebaseDatabase,
                    `chats/${myUserId}-${myFriendUserId}`
                ), newMessengerObject).then(()=>{
                    setTypedText('')
                })
                
                 //"id1-id2": {messenger object}
            }}>
                <Icon
                    style={{
                        padding: 10,
                    }}
                    name='paper-plane' size={20} color={colors.primary} />
            </TouchableOpacity>
        </View>
    </View>
}
export default Messenger