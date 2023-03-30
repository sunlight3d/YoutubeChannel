package com.microservices.myapp.controllers;

import com.microservices.myapp.dtos.ProductDTO;
import com.microservices.myapp.dtos.ProductResponse;
import com.microservices.myapp.services.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/products")
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public void insertProduct(@RequestBody ProductDTO productDTO) {
        productService.insertProduct(productDTO);
    }
    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public List<ProductResponse> getAllProducts() {
        return productService.getAllProducts();
    }
}
