/**
yarn add axios
yarn add react-native-vector-icons
yarn add @react-navigation/bottom-tabs
yarn add @react-navigation/drawer
yarn add @react-navigation/native
yarn add @react-navigation/native-stack"
yarn add firebase
yarn add moment
yarn add react-native-chart-kit
yarn add react-native-gesture-handler
yarn add react-native-keyboard-aware-scroll-view
yarn add react-native-reanimated
yarn add react-native-safe-area-context
yarn add react-native-screens
yarn add react-native-vector-icons
yarn add react-navigation
yarn add @react-native-async-storage/async-storage

rmdir /s node_modules

 */
import {AppRegistry} from 'react-native'
import React from 'react';
import {name as appName} from './app.json'
/*
import {
    Welcome, 
    Login, 
    Register,
    FoodList,
    ProductGridView,
    Settings,
} from './screens'
import UITab from './navigation/UITab'
*/
import App from './navigation/App'

let fakedProducts = [
    {
        productName: 'iphone 3',
        year: 2013
    },
    {
        productName: 'iphone 5',
        year: 2015
    },
    {
        productName: 'iphone 4',
        year: 2014
    },
    {
        productName: 'iphone 6',
        year: 2016
    },
]
/*
AppRegistry.registerComponent(appName,
    () => () => <Welcome 
                    x={5} y = {10}
                    person={{
                        name: 'Nguyen Duc Hoang',
                        age: 18,
                        email: 'hoangnd@gmail.com'
                    }}
                    products={fakedProducts}
                    />)
*/
AppRegistry.registerComponent(appName,() => () => <App />)
