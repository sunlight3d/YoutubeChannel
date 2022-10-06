import models.Bicycle
import models.Car
import models.Vehicle

fun sayHello(name: String):Unit {
    println("Hello "+name)
}
//functions which returns value
fun sum(x: Double, y: Double): Double {
    return x + y
}
fun showColor(red: Int, green: Int, blue: Int, alpha: Float) {
    println("color: $red - $green - $blue - $alpha")
}
//function with Variadic Arguments - vararg
fun like(vararg fruits: String) {
    for (fruit in fruits) {
        println("I like $fruit")
    }
}
//infix functions
//can be called without using the period and brackets
infix fun Int.plus(x: Int): Int {
    return this + x
}
infix fun Int.times(x: Int): Int = this * x //one-line function
infix fun String.loves(name: String) = "$this loves $name"
//Higher order function is:
//- function that takes another function as parameter
//OR - function returns a function
fun doSomething(x: Int, y: Int, completion: (Int) -> Unit) {
    println("do something")
    val result = x + y
    completion(result)
}
//function returns a function
fun operation(x: Float): (y:Float) -> Float {
    return fun(y: Float): Float {
        return y * y
    }
}
//lambda function
val getFullName:(String, String) -> String = {
        firstName: String, lastName:String -> run {
            println("This is a lambda function")
            "$firstName $lastName"
    }
}
//another example
val url:(Int, Int)->String = {
    page:Int, limit:Int ->
        "https://yourServerName:port/products?page=$page&limit=$limit"
}
//another simpler example
val squaredNumber:(Int) -> Int = {x -> x * x}
fun describeVehicle(vehicle: Vehicle):String {
    return when(vehicle) {
        is Bicycle -> "This is a bicycle"
        is Car -> "This is a Car"
        else -> "I don't know"
    }
}