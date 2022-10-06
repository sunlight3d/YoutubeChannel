package com.training

import org.springframework.boot.autoconfigure.EnableAutoConfiguration
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.ComponentScan
import org.springframework.scheduling.annotation.EnableScheduling

@SpringBootApplication
@ComponentScan("com.training")
@EnableScheduling
class TrainingAppApplication
fun main(args: Array<String>) {
	runApplication<TrainingAppApplication>(*args)
}
