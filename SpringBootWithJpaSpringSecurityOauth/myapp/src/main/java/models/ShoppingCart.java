package models;

import org.springframework.stereotype.Component;

@Component
public class ShoppingCart {
    public void checkout(String status) {
        //Save logs here
        //Authentication + Authorization
        System.out.println("checkout ShoppingCart.Status: "+status);
    }
}
