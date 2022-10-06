import SwiftUI
import Foundation
/*
var x:Float = 3 //this is a variable
let PI = 3.14
//PI = 5
var a = 1, b = 2, c = 3
print("a: \(a), b: \(b), c: \(c)")
print("integer has min = \(Int.min), max = \(Int.max)")
let y = pow(x, 4)
//dump(y)
print(y)
let cardNumber = 1356_2357_1156_2236 //a very big number
let hasCar = false
print(hasCar)
if hasCar {
    print("yes, I have a car")
} else {
    print("No, I have not any car")
}
*/
//define 2 variables => a tuple
let (x, y) = (2, 4)
//print("x = \(x), y = \(y)")
//string concatenation
print("x = "+String(x)+",y = "+String(y))
var a = 4
print(a * 2 + 1)
a += 2
print(a)
let name:String = "Hoang"
let age:Int = 18
let description = "Name is \(name), age is \(age)"

let someComments = """
    Good, I like it \u{2665},
    Ok, let me check \u{272a}
    Please do it yourself
"""
print(someComments)

var names:[String] = ["John", "Jack", "Tim", "Elon", "Nick"]
print("Number of elements: \(names.count)")
print(names[0])
//iterate an array
for i in 0..<names.count {
    print("\(i) - \(names[i])")
}
for i in 0...3 {
    print("\(i) - \(names[i])")
}
let someOtherFriends = ["Anna", "Taylor"]
names += someOtherFriends
names.insert("Hoang", at: names.count)
print(names)
print("iterate with index")
for (index, name) in names.enumerated() {
    print("index: \(index), name: \(name)")
}
//how to find "Anna" ?
var filteredNames = names.filter { name in
    return name.lowercased() == "anna"
}
dump(filteredNames)
//find names with length > 3
filteredNames = names.filter{ name in
    return name.count > 4
}
dump(filteredNames)
//delete is also "filter"
//now delete element with name = "Taylor"
print("Before delete")
print(names)
names = names.filter {name in
    return name.lowercased() != "taylor"
}
print("After delete")
print(names)
//Add 2 items with the same values
names.insert("Hoang", at: 0)
names.insert("Hoang", at: 0)
print(names)

var fruits:Set<String> = ["Orange", "Lemon", "Pineapple", "Apple", "Kiwi"]
print(fruits)
fruits.insert("Apple")//your cannot add the same value to a "set"
print(fruits)
for (i, fruit) in fruits.enumerated() {
    print("i = \(i), fruit: \(fruit)")
}
let setA:Set<Int> = [1, 3, 4, 5, 6, 9]
let setB:Set<Int> = [15, 23, 4, 5, 88, 77]
print(setA.intersection(setB))
print("differences: \(setA.symmetricDifference(setB))")
print("union: \(setA.union(setB))")
print("count: \(setA.union(setB).count)")
//set has NO dublicated items
//an object as key - value = Dictionary
var user:[String: Any] = [
    "name": "Hoang",
    "age": 18,
    "email": "sunlight4d@gmail.com"
]
dump(user)
if(!user.isEmpty) {
    print("The object is not empty")
}
user["address"] = "Bach Mai street, Hanoi, Vietnam"
user["email"] = nil //remove a key(property)
dump(user)
//update a key
//user["age"] = 20
if let oldAge = user.updateValue(20, forKey: "age") {
    print("The old value of age is: \(oldAge)")
}
//dump(user)
for (key, value) in user {
    print("key = \(key), value = \(value)")
}
print(user.keys)
print(user.values)
var i = 0
while(i < 10){
    i = i + 1
    if(i == 4) {
        break
    }
//    if i % 2 == 0 {
//        continue
//    }
    print(i)
}
//repeat - while, another way
i = 0
repeat {
    print("i = \(i)")
    i = i + 1
} while(i < 5)
let marks:Float = 9.0
switch marks {
    case 0:
        print("very bad, you do nothing")
    case 0..<4:
        print("Quite bad")
    case 4..<5:
        print("You must work harder to pass this Exam")
    case 5..<7:
        print("Normal")
    case 7..<9:
        print("Good")
    case 9...10:
        print("Excellent")
    default:
        print("Not a valid mark")
}
let point = (4, 5) //this is a tuple
switch point {
    case let (x, y) where x < 0 && y < 0:
        print("x < 0 and y < 0")
    case let (x, y) where x > 0 && y > 0:
        print("x > 0 and y > 0")
        //fallthrough
    case let (x, y) where x == 0 && y == 0:
        print("x = 0 and y = 0")
    //let's write other cases
    default:
        print("I donot know")
}
//this is a function
func hello(name: String) {
    print("Hello \(name)")
}
hello(name: "world")
//function that return value
func getFullName(firstName: String, lastName:String) -> String? {
    return "\(firstName) \(lastName)"
}
print(getFullName(firstName: "Nguyen", lastName: "Duc Hoang"))
//function with return an enumeration
enum MarkLevel {
    case bad, normal, good, veryGood, excellent, unknown
}
func getMark(_ mark: Float) -> MarkLevel {
    if mark < 5 && mark >= 0 {
        return MarkLevel.bad
    } else if mark >= 5 && mark < 6 {
        return MarkLevel.normal
    } else if mark >= 6 && mark < 7 {
        return .good
    } else if mark >= 7 && mark < 9 {
        return .veryGood
    } else if mark >= 9 && mark <= 10 {
        return .excellent
    }
    return .unknown
}
//print(getMark(mark: 6.23))
print(getMark(6.5)) //no labeled arguments
//function that return a tuple
func startEnd(numbers: [Float]) -> (start: Float, end: Float) {
    var currentStart:Float = 0.0
    var currentEnd:Float = 0.0
    if numbers.count == 1 {
        currentStart = numbers[0]
        currentEnd = numbers[0]
    } else if numbers.count > 1 {
        currentStart = numbers[0]
        currentEnd = numbers[numbers.count - 1]
    }
    return (currentStart, currentEnd)
}
print(startEnd(numbers: [4.5, 6.8, 9.3, 2.4]))
func rectangleArea(width: Float, height: Float = 0.0) -> Float {
    width * height
}
print("area = \(rectangleArea(width: 10, height: 20))")
print("area = \(rectangleArea(width: 10))")
//variadic parameters
func getTotal(numbers: Double...) -> Double {
    var total:Double = 0.0
    for number in numbers {
        total += number
    }
    return total
}
print(getTotal(numbers: 1,3,5,7,9))
//inout parameter
func changeSomething(xx: inout Int) {
    xx = 12
}
var aa = 33
print(aa)
changeSomething(xx: &aa)
print(aa)
//function type, like "delegate" in C#
func add2Numbers(_ a: Int,_ b: Int) -> Int{
    return a + b
}
var functionA:(Int, Int) -> Int = add2Numbers(_:_:)
print(add2Numbers(1, 2))
//built-in function
//map 2 arrays
let someNumbers: [CGFloat] = [2, 5, 6, 7, 8, 9] //Core Graphics Float
let squaredNumbers = someNumbers.map {
    //this is anonymous function / closures
    return Int(pow($0, 2))
}
print(squaredNumbers)
/*
var reversedNames = names.sorted { s1, s2 in
    //closure / anonymous function with 2 parameters
    return s1 < s2
}
 */
//short hand
var reversedNames = names.sorted {
    //closure / anonymous function with 2 parameters
    return $1 < $0
}

print(reversedNames)
//closure as a parameter
func doSomeBigTasks(input x: Int,
                    completion: (String) -> Void,
                    onFailure: (String) -> Void) {
    //do some works here
    print("do some tasks")
    if(x == 10) {
        completion("This is result")
    } else {
        onFailure("Result failed")
    }
}
doSomeBigTasks(input: 22) { stringResult in
    print("Yes, finished")
    print(stringResult)
} onFailure: { errorResult in
    print("Yes, finished, but failed")
    print(errorResult)
}
//Now we talk about Structure
//structures are value types
struct Rectangle:Equatable {
    var width: Double
    var height: Double
    var _color: String = ""
    //calculated property
    var area: Double {
        get {
            return width * height
        }
    }
    //setter
    var color: String {
        get {
            return _color
        }
        set(value) {
            print("This is setter")
            _color = value
        }
    }
    static func == (rectA: Rectangle, rectB: Rectangle) -> Bool {
        return rectA.width == rectB.width
                && rectA.height == rectB.height
    }
}
var rect1 = Rectangle(width: 100, height: 200)
var rect2 = Rectangle(width: 300, height: 400)
var rect3 = rect1
var rect4 = Rectangle(width: 123, height: 456)
print(rect4.area)
//rect4.area = 111
rect1.color = "red" //setter
print(rect1.color) //this is getter
//rect1 and rect3 are separated objects
//rect1.width = 111
//rect3.width = 222
//print(rect1)
//print(rect3)
//how to compare contents of 2 objects ?
//if rect1 == rect4 {
//    print("rect1 and rect4 has the same contents")
//}
struct Direction {
    static let north = "north"
    static let east = "east"
    static let west = "west"
    static let south = "south"
}
print("I go to \(Direction.west)")
struct Point {
    var x = 0.0, y = 0.0
    func toString() -> String {
        //This is a method
        return "x = \(x), y = \(y)"
    }
    func distanceTo(point: Point) -> Double {
        let result: Double = sqrt(pow(self.x - point.x, 2)
                                  + pow(self.y - point.y, 2))
        return Double(round(result * 100) / 100)
    }
    //mutating method
    mutating func moveTo(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}
var point1 = Point(x: 10, y: 20)
var point2 = Point(x: 30, y: 50)
print(point1.toString())
print("Distance between p1 and p2 : \(point1.distanceTo(point: point2))")
point2.moveTo(x: 99, y: 88)
print("point2 : \(point2)")
enum OnOffSwitch {
    case on, off
    mutating func press() {
        /*
        if self == .on {
            self = .off
        } else if self == .off {
            self = .on
        }
         */
        //use ternary
        self = self == .on ? .off : .on
    }
}
var mySwitch = OnOffSwitch.on
mySwitch.press()
mySwitch.press()
mySwitch.press()
print(mySwitch)
struct Planet {
    private static let planets:[String] = ["mercury", "venus", "earth",
                            "mars", "jupiter", "saturn",
                            "uranus", "neptune"]
    static subscript(i: Int) -> String {
        return planets[i]
    }
}
var planet1 = Planet[0]
var planet3 = Planet[4]
print(planet3)
//class, is "reference type"
class Vehicle {
    //? = can be null
    var speed: Double?
    var color:String?
    //default constructor
    init() {
        speed = 0.0
        color = "white"
    }
    //calculated property
    var description: String {
        //?? = default value
        "Speed: \(speed ?? 0.0), color: \(color ?? "white")"
    }
    init(speed: Double, color: String) {
        self.speed = speed
        self.color = color
    }
}
//init an object
let vehicle1 = Vehicle(speed: 12, color: "green")
print(vehicle1.description)
//child/sub class
class Bicycle: Vehicle {
    var hasBaskit:Bool = true
    var brandName: String? //optional string
    //failable initializer
    convenience init?(speed: Double, color: String,
                      hasBaskit: Bool, brandName:String) {
        if brandName.isEmpty {
            return nil
        }
        self.init(speed: speed, color: color)
        self.hasBaskit = hasBaskit
        self.brandName = brandName
    }
    //Initializer Parameters Without Argument Labels
    convenience init(_ speed: Double,_ color: String,_ hasBaskit: Bool) {
        self.init(speed: speed, color: color)
        self.hasBaskit = hasBaskit
    }
    
    
}
let bicycle1 = Bicycle(speed: 11.22, color: "red",
                       hasBaskit: false, brandName: "lalala")
let bicycle2 = Bicycle(22.3, "blue", true)
dump(bicycle1)
//dump("bicycle2: \(bicycle2)")
//optional chaining
class Department {
    var id:Int
    var departmentName: String
    init(departmentId id: Int, departmentName: String) {
        self.id = id
        self.departmentName = departmentName
    }
}
class Employee {
    var id: Int
    var employeeName: String
    var department:Department? //The employee may be in a department or NOT
    init(employeeId id: Int, employeeName: String,
         department: Department?) {
        self.id = id
        self.employeeName = employeeName
        self.department = department
    }
}
let departmentSales:Department = Department(departmentId: 11,
                                            departmentName: "Sales and Marketing")
let mrJohn:Employee = Employee(employeeId: 22, employeeName: "John",
                               department: nil)
//print("mr John's department: \(mrJohn.department?.departmentName)")
//You can use default value
print("mr John's department: \(mrJohn.department?.departmentName ?? "no department")")
//error handling
enum CalculationError: Error {
    case divideByZero(message: String)
    case valueTooBig(message:String, maximum: Double)
    //other case....
}
func divide2Numbers(number1: Double, number2: Double) throws -> Double {
    if number2 == 0 {
        throw CalculationError.divideByZero(message: "Cannot divide by zero")
        //you can customize your error object here
    }
    guard number1 < 1_000_000 && number2 < 1_000_000 else {
        throw CalculationError.valueTooBig(message: "Value is too big", maximum: 1_000_000)
    }
    return number1 / number2
}
do {
    //try print("3 / 0 is : \(divide2Numbers(number1: 3, number2: 0))")
    try print("3000000 / 1000000 is : \(divide2Numbers(number1: 3000000, number2: 1000000))")
} catch CalculationError.valueTooBig(let message,let maximum) {
    print("Reason: \(message), maximum: \(maximum)")
}
//Asynchronous Functions
//We have 2 api GET requests:
//https://randomuser.me/api/
//https://api.zippopotam.us/us/33162
let urlGetRandomUser = URL(string: "https://randomuser.me/api")
let urlGetDetailCountry = URL(string: "https://api.zippopotam.us/us/33162")
/*
print("begin task 1")
URLSession.shared.dataTask(with: urlGetRandomUser!) {(data, response, error) in
    print("finished get task 1")
}.resume()
print("begin task 2")
URLSession.shared.dataTask(with: urlGetDetailCountry!) {(data, response, error) in
    print("finished get task 2")
}.resume()
//task1 and task2 are async tasks
 */
//now we want task1 run, finish, then start task2, how to do this
func do2Tasks() async {
    do {
        print("begin task 1")
        let (data1, response1) = try await URLSession.shared.data(from: urlGetRandomUser!)
        print("finished task 1")
        print("begin task 2")
        let (data2, response2) = try await URLSession.shared.data(from: urlGetDetailCountry!)
        print("finished task 2")
    }catch {
        
    }
}
import _Concurrency
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
/*
Task.init {
    await do2Tasks()
}
 */
//Extensions = Add more methods to an existing class
import SwiftUI
let color1 = Color(red: 1.0, green: 0.0, blue: 0.0)

extension Color {
    init(_ red: Double, _ green: Double, _ blue: Double) {
        self.init(red: red, green: green, blue: blue)
    }
}
let color2 = Color(1.0, 0.0, 0.0)
print(color1)
print(color2)
