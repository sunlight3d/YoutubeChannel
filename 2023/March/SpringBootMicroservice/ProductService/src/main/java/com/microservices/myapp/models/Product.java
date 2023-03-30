package com.microservices.myapp.models;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.*;
@Document(value = "products")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class Product {
    @Id
    //@GeneratedValue(strategy = GenerationType.IDENTITY)
    private String id;//ObjectID as string
    private String name;
    private String description;
    private double price;
}
