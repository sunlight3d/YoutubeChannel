package storage

class MySQLRepository(val connectionString: String): IStorageRepository {
    override fun makeConnection(connectionString: String) {
        println("connect MySQL DB with $connectionString")
    }
}