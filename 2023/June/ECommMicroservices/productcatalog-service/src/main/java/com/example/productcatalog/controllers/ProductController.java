package com.example.productcatalog.controllers;

import com.example.productcatalog.models.Product;
import com.example.productcatalog.repositories.ProductRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.elasticsearch.client.erhlc.NativeSearchQueryBuilder;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.SearchHit;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.data.elasticsearch.core.query.Query;
import org.springframework.web.bind.annotation.*;;
import org.elasticsearch.index.query.QueryBuilders;


import java.util.List;
import java.util.stream.Collectors;
import static org.springframework.data.elasticsearch.client.elc.QueryBuilders.queryStringQuery;


@RestController
@RequestMapping("/products")
public class ProductController {
    @Autowired
    private ElasticsearchOperations elasticsearchOperations;
    @Autowired
    private ProductRepository productRepository;

    @GetMapping("/")
    public List<Product> getProducts() {
        return (List<Product>) productRepository.findAll();
    }
    @GetMapping("/search")
    public List<Product> searchProducts(@RequestParam("query") String query) {
        Query searchQuery = new NativeSearchQueryBuilder()
                .withQuery(QueryBuilders.queryStringQuery(query))
                .build();

        SearchHits<Product> searchHits = elasticsearchOperations.search(searchQuery, Product.class);
        return searchHits.getSearchHits().stream().map(SearchHit<Product>::getContent).collect(Collectors.toList());
    }
    @GetMapping("/{id}")
    public Product getProduct(@PathVariable String id) {
        return productRepository.findById(id).orElse(null);
    }

    @PostMapping("/")
    public Product createProduct(@RequestBody Product product) {
        return productRepository.save(product);
    }

    @PutMapping("/{id}")
    public Product updateProduct(@PathVariable String id, @RequestBody Product newProduct) {
        return productRepository.findById(id)
                .map(product -> {
                    product.setName(newProduct.getName());
                    product.setCategory(newProduct.getCategory());
                    product.setDescription(newProduct.getDescription());
                    product.setPrice(newProduct.getPrice());
                    return productRepository.save(product);
                })
                .orElse(null);
    }

    @DeleteMapping("/{id}")
    public void deleteProduct(@PathVariable String id) {
        productRepository.deleteById(id);
    }
}
