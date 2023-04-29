package com.tutorial.productservice.services;
import com.tutorial.productservice.dtos.ProductDTO;
import com.tutorial.productservice.models.Product;
import com.tutorial.productservice.repositories.ProductRepository;
import com.tutorial.productservice.responses.ProductResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    /*
    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }
    */
    public void insertProduct(ProductDTO productDTO) {
        Product product = Product.builder()
                .name(productDTO.getName())
                .description(productDTO.getDescription())
                .price(productDTO.getPrice())
                .build();
        this.productRepository.insert(product);
        log.info("{} is saved", product.getName());
    }
    public List<ProductResponse> getAllProducts() {
        List<Product> products = productRepository.findAll();
        return (List<ProductResponse>)products.stream()
                .map(product -> ProductResponse
                        .builder()
                        .id(product.getId())
                        .name(product.getName())
                        .description(product.getDescription())
                        .build()
                ).toList();
    }
}