package models

class Car(name: String, year: Int, var engineSize:Float, var horsePower: Int)
    : Vehicle(name, year){
    override fun toString(): String {
        return "${super.toString()},engineSize: $engineSize, horsePower:$horsePower"
    }
}