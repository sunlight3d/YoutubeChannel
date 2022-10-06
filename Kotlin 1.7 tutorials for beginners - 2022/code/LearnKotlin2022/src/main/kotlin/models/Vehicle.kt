package models
//sealed is "abstract" => cannot create object from it
//but it can be inherited
sealed class Vehicle(var name: String, var year:Int) {
    override fun toString(): String = "name:$name, year:$year"
}