import React, {useState, useEffect} from 'react';
import {
    Text, 
    View,
    Image,
    ImageBackground,
    TouchableOpacity,
    TextInput,
    KeyboardAvoidingView,
    Keyboard,
    Dimensions
} from 'react-native'
import {images, colors, icons, fontSizes} from '../constants'
import Icon from 'react-native-vector-icons/FontAwesome5'
import { convertDateTimeToString } from '../utilies/DateTime';
import {
    user as UserRepository,
    population as PopulationRepository,    
} from '../repositories'
// import {
//     LineChart,
//     BarChart,
//     PieChart,
//     ProgressChart,
//     ContributionGraph,
//     StackedBarChart
// } from "react-native-chart-kit"  
import { SafeAreaView } from 'react-navigation';
const screenWidth = Dimensions.get("window").width;
const screenHeight = Dimensions.get("window").height;
const chartConfig = {
    backgroundGradientFrom: 'white',
    backgroundGradientFromOpacity: 0,
    backgroundGradientTo: "white",
    backgroundGradientToOpacity: 1.0,
    //color: (opacity = 1) => `rgba(26, 255, 146, ${opacity})`,
    color: (opacity) => colors.primary,
    strokeWidth: 1, // optional, default 3
    barPercentage: 0.5,
    useShadowColorFromDataset: false // optional
  }

function Profile(props) {
    const [user, setUser] = useState({})        
    const [populations, setPopulations] = useState([])        
    //call when component loaded => componentDidMount    
    useEffect(() => {        
        UserRepository.getUserDetail()
            .then(responseUser => setUser(responseUser))            
        PopulationRepository.getPopulation({
            drilldowns: 'Nation',
            measures: 'Population'
        }).then(responsePopulations => setPopulations(responsePopulations))    
    },[])
    //UserRepository.getUserDetail()    
    const {email, dateOfBirth, 
        gender,userId, 
        address, username,url, 
        phone, registeredDate } = user             
    return <SafeAreaView style={{
            flex: 1,                    
            paddingTop: 50,
            paddingStart: 20,
            backgroundColor: 'rgba(0,0,0,0.6)'
        }}>
        <Image
            style={{
                width: 160,
                height: 160,
                resizeMode: 'cover',
                borderRadius: 80,
                alignSelf: 'center',
                marginBottom: 20,
            }}
            source={{
                uri: url
            }} />
        <View style={{flexDirection: 'row'}}>
            <Text style={{
                fontWeight: 'bold',                 
                fontSize: fontSizes.h5}}>Username:  </Text>
            <Text>{username}</Text>
        </View>
        <View style={{flexDirection: 'row'}}>
            <Text style={{fontWeight: 'bold', fontSize: fontSizes.h5}}>Email:  </Text>
            <Text>{email}</Text>
        </View>
        <View style={{flexDirection: 'row'}}>
            <Text style={{fontWeight: 'bold', fontSize: fontSizes.h5}}>DOB:  </Text>
            <Text>{convertDateTimeToString(dateOfBirth)}</Text>
        </View>
        <View style={{flexDirection: 'row'}}>
            <Text style={{fontWeight: 'bold', fontSize: fontSizes.h5}}>Gender:  </Text>
            <Text>{gender}</Text>
        </View>
        <View style={{flexDirection: 'row'}}>
            <Text style={{fontWeight: 'bold', fontSize: fontSizes.h5}}>Address:  </Text>
            <Text>{address}</Text>
        </View>
        <View style={{flexDirection: 'row'}}>
            <Text style={{fontWeight: 'bold', fontSize: fontSizes.h5}}>Phone:  </Text>
            <Text>{phone}</Text>
        </View>
        <View>      
            <Text>{JSON.stringify(populations)}</Text>      
            {/* <LineChart
                data={{
                    labels: populations.sort((a, b) => parseInt(a.year)-parseInt(b.year))
                        .map(item => item.year),
                    datasets: [
                      {
                        data: populations.sort((a, b) => parseInt(a.year)-parseInt(b.year))
                            .map(item => Math.floor(item.population/1000_000, 0)),
                        color: (opacity = 1) => `rgba(134, 65, 244, ${opacity})`, // optional
                        strokeWidth: 2 // optional
                      }
                    ],
                    legend: ["Population/Year"] // optional
                  }}
                width={screenWidth}
                height={220}
                chartConfig={chartConfig}
                bezier
            /> */}
        </View>
    </SafeAreaView>
}
export default Profile