package com.training.controllers

import com.training.exceptions.CarNotFoundException
import com.training.models.Car
import com.training.repositories.CarRepository
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.util.ObjectUtils
import org.springframework.web.bind.annotation.*
import org.springframework.web.util.UriComponentsBuilder
@RestController
public class CarController(val repository: CarRepository) {
    @GetMapping("/cars")
    fun findAll(): ResponseEntity<MutableIterable<Car?>> {
        val cars = repository.findAll()
        if (cars.isEmpty()) {
            return ResponseEntity(HttpStatus.NO_CONTENT)
        }
        return ResponseEntity(cars, HttpStatus.OK)
    }

    @PostMapping("/cars")
    //curl -X POST --location "http://localhost:8080/cars" -H "Content-Type: application/json" -d "{ \"text\": \"Hello!\" }"
    fun insert(
        @RequestBody newCar: Car,
        uri: UriComponentsBuilder): ResponseEntity<Car> {
        val persistedGadget = repository.save(newCar)
        if (ObjectUtils.isEmpty(persistedGadget)) {
            return ResponseEntity<Car>(HttpStatus.BAD_REQUEST)
        }
        val headers = HttpHeaders()
        headers.location = uri.path("/cars/{carId}")
            .buildAndExpand(newCar.id).toUri();
        return ResponseEntity(headers, HttpStatus.CREATED)
    }

    // Single item
    //curl -v localhost:8080/cars/99
    @GetMapping("/cars/{id}")
    fun find(@PathVariable("id") carID: Long): ResponseEntity<Car> {
        val car = repository.findById(carID)
        if(car.isPresent) {
            return ResponseEntity(car.get(), HttpStatus.OK)
        }
        return ResponseEntity(HttpStatus.NOT_FOUND)
    }

    @PutMapping("/cars/{id}")
    fun update(
        @RequestBody inputCar: Car,
        @PathVariable("id") carId: Long): ResponseEntity<Car?>? {
        var result:ResponseEntity<Car?>? = null;
        repository.findById(carId).map {
            var updatedCar = it?.copy(
                name = inputCar.name,
                year = inputCar.year,
                engineSize = inputCar.engineSize,
                horsePower = inputCar.horsePower,
            )
            if(updatedCar != null) {
                result = ResponseEntity(repository.save(updatedCar), HttpStatus.OK)
            } else {
                result = ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR)
            }
        }
        return result
    }

    @DeleteMapping("/cars/{id}")
    fun delete(@PathVariable id: Long) {
        repository.deleteById(id)
    }
}