
import React, {Component, useState} from 'react'
import {
    SafeAreaView, 
    Text, 
    View,
    Image,
    TouchableOpacity,
    ImageBackground,
    FlatList,
} from 'react-native'
import { NavigationContainer } from '@react-navigation/native'
import { createNativeStackNavigator } from '@react-navigation/native-stack'
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs'
import { StackRouter } from 'react-navigation'
import {Welcome, Login, Register, Messenger} from '../screens'
/**
 - Call API(Application Programming Interface)
 - POST, GET, PUT, DELETE
 - Postman(Postwoman)
 - find some public apis
 */
import {
    createDrawerNavigator,
    DrawerContentScrollView,
    DrawerItemList,
    DrawerItem,
  } from '@react-navigation/drawer'

const Stack = createNativeStackNavigator()
import UITab from './UITab'
function App(props) {
    return <NavigationContainer>
        <Stack.Navigator initialRouteName='Welcome' screenOptions={{
            headerShown: false
        }}>
            <Stack.Screen name={"Welcome"} component={Welcome}/>
            <Stack.Screen name={"Login"} component={Login}/>
            <Stack.Screen name={"Register"} component={Register}/>
            <Stack.Screen name={"UITab"} component={UITab}/>     
            <Stack.Screen name={"Messenger"} component={Messenger}/>             
        </Stack.Navigator>
    </NavigationContainer>
}
export default App