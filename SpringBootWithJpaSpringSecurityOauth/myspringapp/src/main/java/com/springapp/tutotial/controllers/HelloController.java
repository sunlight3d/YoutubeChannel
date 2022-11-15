package com.springapp.tutotial.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

//@Controller
@RestController
public class HelloController {
    @RequestMapping(value="/", method= RequestMethod.GET)
    public String sayHello() {
        return "Hello Hoang, this is the first Rest API response !";
    }
}
