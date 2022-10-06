package models
import kotlin.reflect.KProperty
data class User(val id:Int, var name:String, var email:String) {
    //you can also which properties determine "equal"
    override fun equals(other: Any?): Boolean {
        return other is User
                && this.id == other.id
                && this.email == email
    }
    //property
    var age:Int by UserDelegate()
    //you can also rewrite the hashCode method
    override fun hashCode(): Int {
        return id + name.hashCode() + email.hashCode()
    }
    //lazy delegates
    val description:String by lazy {
        "id:$id, name: $name, email: $email"
    }
}
class UserDelegate {
    private var value:Int = 0
    //getter
    operator fun getValue(user: User, property: KProperty<*>): Int {
        println("Call getValue of ${property.name}")
        return value
    }
    operator fun setValue(user: User, property: KProperty<*>, i: Int) {
        println("Call setValue of ${property.name}")
        value = i
    }
}