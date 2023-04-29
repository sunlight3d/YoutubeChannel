package com.example.productcatalog.repositories;
import com.example.productcatalog.models.*;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
public interface ProductRepository extends ElasticsearchRepository<Product, String> {
}