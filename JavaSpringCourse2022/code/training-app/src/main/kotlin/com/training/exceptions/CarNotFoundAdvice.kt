package com.training.exceptions

import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.ControllerAdvice
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.bind.annotation.ResponseStatus

@ControllerAdvice
class CarNotFoundAdvice {
    @ResponseBody
    @ExceptionHandler(CarNotFoundException::class)
    @ResponseStatus(HttpStatus.NOT_FOUND) //HTTP 404
    fun carNotFoundHandler(exception: CarNotFoundException): String? {
        return exception.message
    }
}