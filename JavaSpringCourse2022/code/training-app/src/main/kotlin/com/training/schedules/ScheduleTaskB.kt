package com.training.components

import lombok.extern.java.Log
import lombok.extern.log4j.Log4j2
import mu.KotlinLogging
import org.slf4j.LoggerFactory
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component

import java.text.SimpleDateFormat
import java.time.LocalDateTime

@Component
class ScheduleTaskB {
    val logger = KotlinLogging.logger {}
    var count = 0
    @Scheduled(fixedRate = 2000)
    fun doSomethingB() {
        count ++;
        logger.info("$count TaskB is running at: ${LocalDateTime.now()}");
    }
}