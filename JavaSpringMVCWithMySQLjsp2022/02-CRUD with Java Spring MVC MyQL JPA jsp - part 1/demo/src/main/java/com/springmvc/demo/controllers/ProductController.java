package com.springmvc.demo.controllers;

import com.springmvc.demo.models.Category;
import com.springmvc.demo.models.Product;
import com.springmvc.demo.repositories.CategoryRepository;
import com.springmvc.demo.repositories.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
@RequestMapping(path = "products")
public class ProductController {
    @Autowired
    ProductRepository productRepository;
    @Autowired //Inject "categoryRepository" - Dependency Injection
    private CategoryRepository categoryRepository;

    //http:localhost:8083/products/getProductsByCategoryID/C0103
    @RequestMapping(value = "/getProductsByCategoryID/{categoryID}", method = RequestMethod.GET)
    public String getProductsByCategoryID(ModelMap modelMap, @PathVariable String categoryID) {
        Iterable<Product> products = productRepository.findByCategoryID(categoryID);
        modelMap.addAttribute("products", products);
        return "productList"; //"productList.jsp"
    }
    @RequestMapping(value = "/changeCategory/{productID}", method = RequestMethod.GET)
    public String changeCategory(ModelMap modelMap,  @PathVariable String productID) {
        Iterable<Category> categories = categoryRepository.findAll();
        modelMap.addAttribute("categories", categories);
        modelMap.addAttribute("product", productRepository.findById(productID).get());
        return "assign";//assign.jsp
    }
    ///products/updateProduct/${product.getProductID()}
    @RequestMapping(value = "/updateProduct/{productID}", method = RequestMethod.POST)
    public String updateProduct(ModelMap modelMap,
                                @ModelAttribute("product") Product product,
                                @PathVariable String productID
    ) {
        if(productRepository.findById(productID).isPresent()) {
            Product foundProduct = productRepository
                    .findById(product.getProductID()).get();
            if(product.getProductName() != null) {
                foundProduct.setProductName(product.getProductName() );
            }
            if(product.getCategoryID() != null) {
                foundProduct.setCategoryID(product.getCategoryID());
            }
            if(product.getDescription() != null) {
                foundProduct.setDescription(product.getDescription());
            }
            if(product.getPrice() > 0) {
                foundProduct.setPrice(product.getPrice());
            }
            productRepository.save(foundProduct);
        }
        return "redirect:/products/getProductsByCategoryID/"+product.getCategoryID();
    }


}
