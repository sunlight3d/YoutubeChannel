package com.example.productcatalog.repositories;

import com.example.productcatalog.models.Category;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

public interface CategoryRepository extends ElasticsearchRepository<Category, String> {
}