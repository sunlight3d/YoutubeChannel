package com.myapp.orderservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@SpringBootApplication
public class OrderserviceApplication {
	public static void main(String[] args) {
		SpringApplication.run(OrderserviceApplication.class, args);
	}

}
/*
Create 2 entities in Java spring:
Order(table: orders), 1 Order(id, orderNumber:string) has many OrderDetail(table order_details),
OrderDetail(productSkuCode: string, price: decimal, quantity: unsigned int)
Some constraints: productSkuCode must be at least 3 characters, price must be >= 0, quantity > 0
use lombok

create DTO(Data Transfer Object) for these 2 entities(with lombok)

I want to connect to MySQL from Java Spring.My DB's name:order_service, username:root,mysql port:3306
when Java code changed, data in database is updated, not be deleted or dropped
Java Spring server is port: 8082
Write these settings in application.properties

Let write a faked json object with this format:
"orderDetails": array of some objects(each object has productSkuCode,price,quantity)


* */
