console.log("Hello world!");
//alert("This is an alert")
let name = "Hoang" //this is a variable
//js is case-sensitive
let Name = "Jonny"
console.log("name: " + name+ ",Name: " + Name)
//this is a number variable
let x = 10
let y = 3
console.log("x: " + x)
console.log("y: " + y)
console.log(y ** 5) //** = POWER 
if(1 == 1)  {
    var z = 133    
}
console.log("z: " + z)
console.log(x == '10')
const PI = 3.1416
//PI = 55
console.log(`PI = ${PI}`)
const hasMercedesG63 = false
console.log(hasMercedesG63)

let message = "I like these cars \
And many others \
Please buy and buy \
"
console.log(message)
var poem = 
"The plates will still shift \n\
and the clouds will still spew. \n\
The sun will slowly rise \n\
and the moon will follow too."
console.log(poem)
//Now we learn "control flow"
let i = 0
while(i < 10) {
    i++
    console.log(`item = ${i}`)
}
let marks = 10
if(marks >= 0 && marks < 4) {
    console.log('Bad')
} else if(marks >= 4 && marks <= 6) {
    console.log('Normal')
} else if(marks > 6 && marks < 8) {
    console.log('Good')
} else if(marks >=8 && marks <= 10) {
    console.log('Excellent')
} else {
    console.log("Mark is undefined")
}
//iterate using for loop
for(let i = 0; i < 10; i++) {
    if(i % 2 == 0){
        continue
    }
    console.log(`i = ${i}`)
}
//Define an array
let cars = [
    'Mercedes G63', 
    'MC Laren 570S',
    'Lamborghini Aventador',
    'Ferrari F8 Spider',
    'Appolo IE'
]
for(let i = 0; i < cars.length - 1; i++) {
    console.log(cars[i])
}
console.log('using foreach')
cars.forEach(function(car){
    console.log(car)
})
console.log('using foreach with arrow function')
cars.forEach((car) => {
    console.log(car)
})
//using for of
for(let car of cars){
    console.log(`name: ${car}`)
}
for(let i in cars) {
    console.log('i = '+i)
}
cars.forEach((car, index, array) => {
    console.log(`${index+1}-${car}`)
})
//add more items
cars.push("EQS Mercedes Sedan")
console.log(cars)
//filter items, how to find some items which contains "mercedes"
let filteredCars = cars.filter(function(car) {
    return car.toLowerCase().includes("mercedes")
})
console.log(`filteredCars = ${filteredCars}`)
console.log(`we found ${filteredCars.length} cars`)
//an array of numbers
let someNumbers = [3, 5, 7, 1, 5, 9]
//someNumbers[0] = 4
//what is "mapped array" ?
let squaredNumbers = someNumbers.map(eachNumber => {
    return eachNumber ** 3
})
console.log(`someNumbers = ${someNumbers}`)
console.log(`squaredNumbers = ${squaredNumbers}`)
//delete an item = filter
console.log('After deleted')
//delete all items which less than 5
someNumbers = someNumbers.filter(eachNumber => eachNumber >= 5)
console.log(`someNumbers = ${someNumbers}`)
//Functions in JS
function sayHello(name) {
    console.log(`Hello ${name}`)
}
sayHello('Hoang')
function sum(x, y) {
    return x + y
}
//function expression
const multiply = function (a, b) {
    return a * b
}
//one line function
const divide = (a, b) => (a / b).toFixed(2)
console.log(`sum 5 and 4 is ${sum(5, 4,)}`)
console.log(`multiply 4 and 6 = ${multiply(4, 6)}`)
console.log(`5 divide by 7 is ${divide(5, 7)}`)
//function with default arguments:
function hello(name = "Guest") {
    console.log(`Hello ${name}`)
}
hello('Hoang')
hello()
//function as an "argument"
let seconds = 0
/*
setInterval(function () {
    //call this function each 2 seconds
    seconds = seconds + 1
    //console.log(`${seconds}. call this function each 1 seconds`)
    console.log(seconds)
}, 1000)
*/
//Define an object
let point = {}
point.a = 4
point.b = 6
//console.log(point.y)
//console.log(`a = ${point.a}, b = ${point.b}`)
//destructuring an object
let {a, b} = point
a = 123
console.log(`a = ${a}, b = ${b}`)
console.log(point.a)
//point.a = 111
point['a'] = 222
console.log(point)
console.log(typeof point)
console.log(typeof point.b)
const myDreamCar = {
    maker: 'Mercedes',
    model: 'G63',
    year: 2022
}
console.log(myDreamCar.color === undefined)
console.log(myDreamCar)
//alert(JSON.stringify(myDreamCar))
for(let key in myDreamCar) {
    console.log(`key = ${key}`)
}
console.log("List of values of an object")
for(let value of Object.values(myDreamCar)) {
    console.log(`value = ${value}`)   
}
//clone an object
const myDreamCar2 = {...myDreamCar}
//change the first
myDreamCar.year = 2021
console.log(myDreamCar)
console.log(myDreamCar2)
//create object using constructor function
function Car(maker, model, year, color) {
    this.maker = maker
    this.model = model
    this.year = year
    this.color = color
    //define methods out of constructor    
}
let car1 = new Car('McLaren', 'McLaren 720s Spider', 2021, 'red')
let car2 = new Car('Toyota', 'Tundra', 2022, 'army green')
let car3 = new Car('Mazda', 'MAZDA CX-30', 2019, 'black')
let car4 = new Car('Tesla', 'Tesla Model Y', 2020, 'blue')
car1.run = function(speed) {
    console.log(`I run at speed: ${speed} km/h`)
}
car1.run(236)
//add other methods
car1.describe = function(){
    console.log(`maker: ${this.maker}, \
                model: ${this.model} \
                model: ${this.year} \
                model: ${this.color} `)
}
car1.describe()
car2.describe = car1.describe
car2.describe()
car3.describe = car1.describe
car3.describe()
//how to delete a property ?
console.log(car1)
//debugger
delete car1.color
console.log('After delete color')
console.log(car1)
//define a class
class Person {
    constructor(name, email, age) {
        this.name = name ?? ''
        this.email = email ?? ''
        this.age = age || 18
    }
}
class Employee extends Person {
    //default constructor
    /*
    constructor() {
        this.name = ''
        this.departmentName = 'No department'
    }
    */
    //constructor with arguments
    constructor(name, email, age, department) {
        super(name, email, age)
        this.departmentName = department ?? 'No department'
    }
}
let employeeA = new Employee()
console.log(employeeA)
let employeeB = new Employee('Hoang', 'IT')
console.log(employeeB)
let employeeC = new Employee('John', 'john@gmail.com', 25, 'Sales')
console.log(`employee C: ${JSON.stringify(employeeC)}`)
let personC = new Person('Anna', 'anna@gmail.com', 22)
console.log(`personC : ${JSON.stringify(personC)}`)
//A Promise is an object representing
//the eventual completion or failure of 
//an asynchronous operation
//Example: send a request to Api server
const urlGetEntries = 'https://api.publicapis.org/entries'
const urlGetCategories = 'https://api.publicapis.org/categories'

async function fetchDataFromAPIServer(url) {
    return new Promise((resolve, reject) => {
        debugger
        //console.log("Begin sending request")    
        fetch(url).then(response =>{
            //this is success block
            //console.log('received response')
            //debugger
            response.json().then(data => {
                ///console.log('changed response to json object')
                //debugger
                resolve({result: data, error: '', message: 'Fetch data successfully'})
            })
        }).catch(error => {
            //debugger
            //console.log('error : '+error)
            reject({error: error, message: 'Cannot get data because ...'})
            //this is failed block
        })
    })
    
}
//now do 2 asynchronous tasks !
/*
console.log('Begin task 1')
fetchDataFromAPIServer(urlGetEntries).then(result =>{
    //debugger
    console.log('End task 1')
}).catch(error => {
    //debugger
})
console.log('Begin task 2')
fetchDataFromAPIServer(urlGetCategories).then(result =>{
    //debugger
    console.log('End task 2')
}).catch(error => {
    //debugger
})
*/
//now do task1, then task2 => async / await
async function do2AsyncTasks() {
    try {
        console.log('Begin task 1')
        let result1 = await fetchDataFromAPIServer(urlGetEntries)
        console.log('End task 1')
        console.log('Begin task 2')
        let result2 = await fetchDataFromAPIServer(urlGetCategories)
        console.log('End task 2')
    }catch(exception) {
        console.log('Error: '+JSON.stringify(exception))
    }
}
do2AsyncTasks()
