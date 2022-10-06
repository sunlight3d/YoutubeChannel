package enums

enum class RequestError(val message: String) {
    BAD_REQUEST("Invalid request"),
    INTERNAL_ERROR("Internal Server Error"),
    SUCCESS("Server processes request successfully");
    //you can define more methods here
    fun wordCount() = message.trim()
                        .split("\\s+".toRegex()).size
}