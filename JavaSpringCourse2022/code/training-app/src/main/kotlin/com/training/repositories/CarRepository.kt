package com.training.repositories

import com.training.models.Car
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
public interface CarRepository : JpaRepository<Car?, Long?> {
    @Query("select * from cars")
    fun findCars(): List<Car>
}