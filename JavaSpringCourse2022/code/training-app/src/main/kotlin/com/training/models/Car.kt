package com.training.models

import java.util.*
import javax.persistence.*
@Table(name = "cars")
data class Car(
    @Id val id: String?,
    val name: String,
    val year: String,
    val engineSize:Float,
    val horsePower: Int
)