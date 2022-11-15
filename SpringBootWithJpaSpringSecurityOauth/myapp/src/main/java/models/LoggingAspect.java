package models;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LoggingAspect {
    @Before("execution(* ShoppingCart.checkout(..))")
    public void before() {
        System.out.println("Before checkout");
    }
    @After("execution(* ShoppingCart.checkout(..))")
    public void after() {
        System.out.println("After checkout");
    }
}
