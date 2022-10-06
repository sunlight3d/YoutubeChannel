import enums.Quality
import enums.RequestError
import models.Bicycle
import models.*
import storage.IStorageRepository
import storage.MyDBRepository
import storage.MySQLRepository
import utilities.Calculation

fun main() {
    println("Hello world")
    var x = 5 //this is a variable
    var a: Int = 120
    println("x is : $x, a = $a")
    //you can change value of a variable
    x = 6
    println("x now is : $x")
    val y = 44 //val = cannot be assigned
    //y = 55
    //function = a block of code
    sayHello("Hoang")
    println("sum 2 and 3 is : ${sum(2.0, 3.0)}")
    //you can use labeled arguments
    println("sum 4 and 5 is : ${sum(x = 4.0, y = 5.0)}")
    showColor(255, 0, 0, 0.5f)
    like("apple", "orange", "pineapple", "kiwi")
    val z = 12 plus 5
    println("z = $z")
    println("5 + 3 is : ${5 plus 3}")
    println("6 times 5 = ${6 times 5}")
    var message: String = "John" loves "Mary" //non-null type String
    //message = null
    println(message)
    var email: String? //nullable
    //email = "hoang@gmail.com"
    email = null
    println("email's length is : ${email?.length ?: 0}")
    println("email = ${email ?: "someone@gmail.com"}") //default value
    /*
    doSomething(1, 2, completion = {result:Int -> run {
        println("result is : $result")
    }})
     */
    //more simpler way
    /*
    doSomething(1, 3) {result:Int ->
        run {
            println("result is : $result")
        }
    }
    */
    //simplest way
    doSomething(2, 3) {
        println("result is: $it") //item
    }
    println("operation = ${operation(x = 10.0f)(20.0f)}")
    println("Full name = ${getFullName("Nguyen", "Duc Hoang")}")
    println(url(1, 200))
    println(squaredNumber(30))
    url(1, 200).let {
        println("It means that url is NOT NULL")
        println(it)
        println("Do more ...")
    }
    //class in Kotlin
    //define an object from class
    val user1 = User(1, "hoang", "sunlight4d@gmail.com")
    val user2 = User(1, "hoang", "sunlight4d@gmail.com")
    //2 data objects with the same values => the same hashcode
    println(user1.hashCode())
    println(user2.hashCode())
    if (user1.equals(user2)) {
        println("user1 and user2 has the same content")
    }
    user1.name = "John"
    println(user1) //you can change property's value of a "val" object
    //but you cannot reference to another object / cannot be reassigned
    //user1 = User(2, "tony", "tony@gmail.com")
    val user3 = User(3, "mary", "mary@gmail.com")
    //clone this object
    //val user4 = user3.copy()
    //clones and changes properties
    val user4 = user3.copy(email = "mary123@gmail.com")
    println(user3)
    println(user4)
    //enum classes
    val quality: Quality = Quality.GOOD
    val qualityMessage: String = when (quality) {
        //when = switch-case
        Quality.BAD -> "This is bad"
        Quality.NORMAL -> "Quality is normal"
        Quality.GOOD -> "Yes, it is Good"
        Quality.EXCELLENT -> "Wooo, excellent"
    }
    println(qualityMessage)
    val requestError: RequestError = RequestError.SUCCESS
    println(requestError)
    println(requestError.message)
    println(requestError.wordCount())
    //define a key-value object
    var person1 = object {
        var name = "Hoang"
        var emailAddress = "sunlight4d@gmail.com"
        var age = 18
        override fun toString(): String =
            "name:$name, email:$emailAddress, age:$age"
    }
    println(person1)
    val person2 = mutableMapOf<String, Any>(
        "name" to "John",
        "email" to "john@gmail.com",
        "age" to 22
    )
    person2["email"] = "john123@gmail.com" //you can change if person2 is a "mutable map"
    person2["age"] = 18
    println(person2)
    //companion object => like "static"
    println(Calculation.multiply(2, 5))
    println("PI = ${Calculation.PI}")
    //Sealed types cannot be instantiated => it is "abstract"
    //val vehicle:Vehicle = Vehicle("haha", 2022)
    val bicycle: Bicycle = Bicycle("vihaha", 2022, hasBasket = true)
    println(bicycle)
    val car1: Car = Car("GLB 200 7G-DCT", 2020, 81.3f, horsePower = 163)
    println(car1)
//    println(car1.name)
//    println(car1.horsePower)
    with(car1) {
        //print other fields here
        println(horsePower)
    }
    //you can update multiple properties here
    bicycle.apply {
        year = 2020
        hasBasket = false
    }
    println(bicycle)
    //check object type
    println(describeVehicle(vehicle = car1))
    car1.run(112.3)
    var someNumbers = mutableListOf<Int>(1, 3, 4, -2, 5, -3, 7)
    someNumbers.forEach {
        print("$it ")
    }
    if(someNumbers.any {it < 0}) {
        println("At least 1 item is negative")
    }
    if (someNumbers.all{it < 100}) {
        println("All items are < 100")
    }
    if (someNumbers.none{it == 100}) {
        println("No item has value = 100")
    }
    val someFloats = mutableListOf<Float>(3.5f, 2.3f, 4.6f, 1.8f)
    someFloats[0] = 22.2f
    println(someFloats)
    var cars = mutableListOf<Car>(
        Car("GLB 200 7G-DCT", 82020,1.3f, 163),
        Car("GLB 200 d 8G-DCT", 2020,119f, 150),
        Car("Lexus CT200H F SPORT", 2014,109.7f, 136),
        Car("Lexus CT200H Hybrid", 2018,119f, 150),
        Car("Jetta Advance 1.6 TDI 105HP BlueMotion Technology DSG 7",
            2011,97.5f, 105),
        Car("Jetta Sport 1.4 TSI 160HP DSG 7 speed", 2011,84.8f, 160),
        Car("Bentley Flying Spur W12", 2013,243.7f, 528),
        Car("Bentley Brooklands 2008", 2007,412.6f, 537),
        Car("Continental GTC 6.0 W12", 2019,363.1f, 635),
        Car("Qashqai DIG-T 158 4WD Auto", 2021,81.3f, 158),
        Car("Nissan Laurel JC32 2.8 D", 2020,172.5f, 90),
    )
    println(cars)
    println("Add 1 car to the first item")
    cars.add(0, Car("Nissan Murano Z50 3.5 (234HP)", 2004,213.5f, 234),)
    println("Add to the last item")
    cars.add(Car("Bentley 8 Litre", 1930,487.2f, 230),)
    cars.forEach {
        println(it)
    }
    //filter cars which year is between 2013 and 2016
    var filteredCars = cars.filter { it.year in 2013..2016 }
    //find cars which name contains "lexus"
    filteredCars = cars.filter { it.name.contains("lexus", ignoreCase = true) }
    println("filtered cars:")
    for (item in filteredCars) {
        println(item)
    }
    println("sort the list, by horsePower")
    //var sortedCars = cars.sortedBy { it.horsePower }
    val sortedCars = cars.sortedByDescending { it.horsePower }
    sortedCars.forEach {
        println(it)
    }
    //get car's name and add to a separated list
    val carNames = cars.map { it.name }
    carNames.forEach { println(it) }
    println("There are ${carNames.count()} cars")
    println("First name: ${carNames.first()}, last name: ${carNames.last()}")
    //split/partition a list
    var (newerCars, olderCars) = cars.partition { it.year > 2019 }
    //minimum, maximum
    println(cars.minOf { it.horsePower })
    println(cars.maxOf { it.horsePower })
    //now we talk about delegate, interface
    //var repository = IStorageRepository() //cannot init an object from interface !
    val connectionString = "Server=myServerAddress;Database=myDataBase;Uid=myUsername;Pwd=myPassword;"
    var repository:MySQLRepository = MySQLRepository(connectionString)
    //println(repository)
    var myDBRepository = MyDBRepository(connectionString)
    myDBRepository.makeConnection(connectionString)
    //Delegated properties = make a separated class which override getter/setter
    val user5 = User(11, "Ted", "ted@gmail.com")
    user5.age = 30
    println(user5.age)
    //some standard delegates: lazy, observable
    println(user5.description)
    //create object from key-value map
    val productA = Product(mapOf(
        "name" to "iphone 4",
        "price" to 2000
    ))
    println(productA)
    //observable property => when property's value changes => a function is run
    productA.description = "hehe"
    productA.description = "haha"
    //property's type is Int
    productA.count = 2
    productA.count = 3
    productA.count = -1 //count still 3 because -1 < 0
    println(productA.count)
}