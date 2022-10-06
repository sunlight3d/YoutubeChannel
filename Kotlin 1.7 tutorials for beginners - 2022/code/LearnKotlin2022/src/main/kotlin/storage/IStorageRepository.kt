package storage

interface IStorageRepository {
    fun makeConnection(connectionString: String)
}