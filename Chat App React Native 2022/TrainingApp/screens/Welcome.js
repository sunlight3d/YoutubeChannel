import React, {useState, useEffect} from 'react';
import {
    Text, 
    View,
    Image,
    ImageBackground,
    TouchableOpacity,
    Platform
} from 'react-native'
//component = function
//create a variable which reference to a function 
import {sum2Number, substract2Number, PI} from '../utilies/Calculation'
import {images, icons, colors, fontSizes} from '../constants'
import {UIButton} from '../components'
import Icon from 'react-native-vector-icons/FontAwesome5'
import AsyncStorage from '@react-native-async-storage/async-storage'

import {
    auth,
    onAuthStateChanged,
    firebaseDatabaseRef,
    firebaseSet,
    firebaseDatabase
} from '../firebase/firebase'
function Welcome(props) {
    //state => when a state is changed => UI is reloaded    
    //like getter/setter
    const [accountTypes, setAccountTypes] = useState([
        {
            name: 'Influencer',
            isSelected: true,
        }, 
        {
            name: 'Business',
            isSelected: false,
        }, 
        {
            name: 'Individual',
            isSelected: false,
        },         
    ]) 
    //navigation
    const {navigation, route} = props
    //functions of navigate to/back
    const {navigate, goBack} = navigation
    useEffect(() => {
        onAuthStateChanged(auth, (responseUser) => {
            debugger
            if(responseUser) {                                
                //save data to Firebase                
                let user = {
                    userId: responseUser.uid,                
                    email: responseUser.email,
                    emailVerified: responseUser.emailVerified,
                    accessToken: responseUser.accessToken
                }
                firebaseSet(firebaseDatabaseRef(
                    firebaseDatabase,
                    `users/${responseUser.uid}`
                ), user)
                //save user to local storage
                AsyncStorage.setItem("user", JSON.stringify(user))                
                navigate('UITab')                
            } 
        })
    })
    return <View style={{
        backgroundColor: 'white',
        flex: 100,
    }}>
        <ImageBackground 
            source={
                images.background
            }
            resizeMode='cover'
            style={{
                flex: 100,                  
            }}
        >
            <View style={{                
                flex: 20,                                
            }}>
                <View style={{
                    flexDirection: 'row',
                    height: 50,
                    justifyContent: 'flex-start',
                    alignItems: 'center',
                    marginTop: Platform.OS === 'ios' ? 40 : 0
                }}>
                    <Image
                        source={icons.fire}
                        style={{
                            marginStart: 10,
                            marginEnd: 5,
                            width: 30,
                            height: 30,
                        }}
                    />
                    <Text style={{
                        color: 'white'
                    }}>YOURCOMPANY.CO</Text>
                    <View style={{ flex: 1 }} />
                    <Icon name={'question-circle'}
                        color={'white'}
                        size={20}
                        style={{                            
                            marginEnd: 20
                        }}
                    />
                    {/* <Image
                        source={icons.question}
                        style={{
                            width: 20,
                            height: 20,
                            tintColor: 'white',
                            marginEnd: 10
                        }}
                    /> */}
                </View>
            </View>
            <View style={{
                flex: 20,
                width: '100%',                                
                justifyContent: 'center',
                alignItems: 'center',
            }} >
                <Text style={{
                        marginBottom: 7, 
                        color: 'white',
                        fontSize: fontSizes.h6
                    }}>Welcome to</Text>
                <Text style={{ 
                    marginBottom: 7, 
                    color: 'white',
                    fontWeight: 'bold',
                    fontSize: fontSizes.h5,
                }}>YOURCOMPANY.CO !</Text>
                <Text style={{ 
                    marginBottom: 7, 
                    color: 'white',
                    fontSize: fontSizes.h6, 
                }}>Please select your account type</Text>
            </View>
            <View style={{
                flex: 40,                
            }}>
                {accountTypes.map(accountType => 
                    <UIButton 
                        key={accountType.name}
                        onPress={() => {                                         
                        //accountTypes = newAccountTypes => DONOT DO THIS !
                        setAccountTypes(accountTypes.map(eachAccountType => {
                            return {
                                ...eachAccountType, 
                                isSelected: eachAccountType.name == accountType.name
                            }                            
                        }));
                    }}
                        title={accountType.name}
                        isSelected={accountType.isSelected}
                    />)
                }                              
            </View>

            <View style={{
                flex: 20,                    
            }}>
                <UIButton 
                    onPress={() => {
                        navigate('Login')
                    }}
                    title={'Login'.toUpperCase()}/>
                <Text style={{                     
                    color: 'white',
                    fontSize: fontSizes.h6, 
                    alignSelf: 'center'
                }}>Want to register new Account ?</Text>
                <TouchableOpacity 
                    onPress={()=>{
                        //alert('press register')
                        navigate('Register')
                    }}
                    style={{
                    padding: 5
                    }
                }>
                    <Text style={{
                        color: colors.primary,
                        fontSize: fontSizes.h6,
                        alignSelf: 'center',
                        textDecorationLine: 'underline',
                    }}>Register</Text>
                </TouchableOpacity>
            </View>
        </ImageBackground>
    </View>
}
export default Welcome 
/*
//read object, variable, functions from other modules
const Welcome = (props) => {  
    //destructuring an object
    const {x, y} = props  
    const {person} = props
    //const => let => var
    //destructuring  person object
    const {name, age, email} = person
    const {products} = props    
    //JSX
    return <View style={{
        
    }}>        
        <Text>Value of x = {x}, Value of y = {y}</Text>
        <Text>Name = {name}, email = {email}, age = {age}</Text>
        {products.map(eachProduct => 
            <Text>{eachProduct.productName}, {eachProduct.year}</Text>)}
        <Text>sum 2 and 3 = {sum2Number(2, 3)}</Text>    
        <Text>10 - 8 = {substract2Number(10, 8)}</Text>
        <Text>PI = {PI}</Text>
    </View>
}
*/

