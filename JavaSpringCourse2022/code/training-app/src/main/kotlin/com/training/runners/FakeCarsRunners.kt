package com.training.runners

import com.training.models.Car
import com.training.repositories.CarRepository
import lombok.extern.slf4j.Slf4j
import mu.KotlinLogging
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.CommandLineRunner
import org.springframework.context.annotation.Bean
import org.springframework.stereotype.Component

@Component
@Slf4j
class FakeCarsRunners : CommandLineRunner {
    val logger = KotlinLogging.logger {}
    @Autowired
    private lateinit var carRepository:CarRepository;

    @Throws(Exception::class)
    override fun run(vararg args: String?) {
        //logger.info("this ran")
        carRepository.save(Car("GLB 200 7G-DCT", 82020,1.3f, 163));
        carRepository.save(Car("GLB 200 d 8G-DCT", 2020,119f, 150));
        carRepository.save(Car("Lexus CT200H Hybrid", 2018,119f, 150));
        carRepository.save(Car("Jetta Advance 1.6 TDI 105HP BlueMotion Technology DSG 7",
            2011,97.5f, 105));
        carRepository.save(Car("Bentley Flying Spur W12", 2013,243.7f, 528));
        carRepository.save(Car("Bentley Brooklands 2008", 2007,412.6f, 537));
        carRepository.save(Car("Qashqai DIG-T 158 4WD Auto", 2021,81.3f, 158));
        carRepository.save(Car("Nissan Laurel JC32 2.8 D", 2020,172.5f, 90));
    }
}