package com.microservices.myapp.repositories;

import com.microservices.myapp.models.Product;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ProductRepository extends MongoRepository<Product, String> {

}
