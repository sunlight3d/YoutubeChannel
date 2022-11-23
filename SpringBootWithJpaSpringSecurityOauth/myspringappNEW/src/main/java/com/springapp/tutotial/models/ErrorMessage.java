package com.springapp.tutotial.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;

@NoArgsConstructor
@AllArgsConstructor
@Data //has toString method
public class ErrorMessage {
    private HttpStatus httpStatus;
    private String message;
}
