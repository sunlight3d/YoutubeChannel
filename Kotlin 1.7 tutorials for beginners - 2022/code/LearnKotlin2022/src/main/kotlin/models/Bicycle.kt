package models

class Bicycle(name: String, year:Int, var hasBasket: Boolean)
    :Vehicle(name, year) {
    override fun toString(): String = "${super.toString()}, hasBasket: $hasBasket"
}