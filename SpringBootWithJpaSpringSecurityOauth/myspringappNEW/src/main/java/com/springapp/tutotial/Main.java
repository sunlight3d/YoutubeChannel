package com.springapp.tutotial;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
/*
mvn clean install
Open Maven tab(right), Lifecycle, click clean, click install
Output jar files in target/
packages all dependencies mentioned in the pom file => jar.original
java -jar target/tutotial-0.0.1-SNAPSHOT.jar --spring.profiles.active=test`
Access :8082/actuator
* */
@SpringBootApplication
public class Main {
	public static void main(String[] args) {
		SpringApplication.run(Main.class, args);
	}
}
