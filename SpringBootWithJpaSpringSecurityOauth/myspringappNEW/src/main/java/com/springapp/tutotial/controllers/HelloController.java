package com.springapp.tutotial.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

//@Controller
@RestController
public class HelloController {
    @Autowired
    private Environment env;
    @RequestMapping(value="/", method= RequestMethod.GET)
    public String sayHello() {
        return env.getProperty("welcome.message");
    }
}
