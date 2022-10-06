package com.training.schedules

import org.slf4j.LoggerFactory
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component

import java.time.LocalDateTime

@Component
class ScheduleTaskA {
    val logger = LoggerFactory.getLogger(ScheduleTaskA::class.java)
    var count = 0
    @Scheduled(fixedRate = 4000)
    fun doSomethingA() {
        count ++;
        logger.info("$count TaskA is running at: ${LocalDateTime.now()}");
    }
}