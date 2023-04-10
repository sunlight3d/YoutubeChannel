package com.example.productcatalog.controllers;

import com.example.productcatalog.models.*;
import com.example.productcatalog.repositories.CategoryRepository;
import org.springframework.beans.factory.annotation.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.elasticsearch.core.query.Query;
import org.springframework.web.bind.annotation.*;

import java.util.List;

// ... existing ProductController ...

@RestController
@RequestMapping("/categories")
public class CategoryController {
    @Autowired
    private CategoryRepository categoryRepository;

    @GetMapping("/")
    public List<Category> getCategories() {
        return (List<Category>) categoryRepository.findAll();
    }

    @GetMapping("/{id}")
    public Category getCategory(@PathVariable String id) {
        return categoryRepository.findById(id).orElse(null);
    }

    @PostMapping("/")
    public Category createCategory(@RequestBody Category category) {
        return categoryRepository.save(category);
    }

    @PutMapping("/{id}")
    public Category updateCategory(@PathVariable String id, @RequestBody Category newCategory) {
        return categoryRepository.findById(id)
                .map(category -> {
                    category.setName(newCategory.getName());
                    return categoryRepository.save(category);
                })
                .orElse(null);
    }

    @DeleteMapping("/{id}")
    public void deleteCategory(@PathVariable String id) {
        categoryRepository.deleteById(id);
    }
}