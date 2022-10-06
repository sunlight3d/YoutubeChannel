package com.training.exceptions

public class CarNotFoundException(id: Long)
    : RuntimeException("Could not find car $id")