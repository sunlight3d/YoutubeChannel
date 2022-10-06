package storage

class MyDBRepository(connectionString: String):IStorageRepository
        by MySQLRepository(connectionString) {
}