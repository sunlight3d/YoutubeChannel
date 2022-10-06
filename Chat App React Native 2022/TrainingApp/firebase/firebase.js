import { initializeApp } from 'firebase/app'
import { 
    getAuth, 
    onAuthStateChanged,
    createUserWithEmailAndPassword,   
    signInWithEmailAndPassword,
    sendEmailVerification,  
    //read data from Firebase    
} from "firebase/auth"
//ref = reference to a "collection"
import { 
    getDatabase, 
    ref as firebaseDatabaseRef, 
    set as firebaseSet,
    child,
    get,
    onValue,
} from "firebase/database"

const firebaseConfig = {
    apiKey: "AIzaSyCmWod-y60Gudl3wnoEKczhE6uuu_oupyM",
    authDomain: "trainingappreactnative2022.firebaseapp.com",
    databaseURL: "https://trainingappreactnative2022-default-rtdb.asia-southeast1.firebasedatabase.app",
    projectId: "trainingappreactnative2022",
    storageBucket: "trainingappreactnative2022.appspot.com",
    appId: '1:1032082090705:android:7b1d436d5bbce0e85c73f0',
    messagingSenderId: "1032082090705",
}  
const app = initializeApp(firebaseConfig)
const auth = getAuth()
const firebaseDatabase = getDatabase()
export {
    auth,
    firebaseDatabase,
    createUserWithEmailAndPassword,
    onAuthStateChanged,
    firebaseSet,
    firebaseDatabaseRef,
    sendEmailVerification,
    child,
    get,
    onValue, //reload when online DB changed
    signInWithEmailAndPassword,
}

