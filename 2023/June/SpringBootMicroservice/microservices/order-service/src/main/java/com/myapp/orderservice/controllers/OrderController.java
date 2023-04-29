package com.myapp.orderservice.controllers;

import com.myapp.orderservice.dtos.OrderDTO;
import com.myapp.orderservice.services.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/orders")
@RequiredArgsConstructor
public class OrderController {
    private final OrderService orderService;
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public String placeOrder(@RequestBody OrderDTO orderDTO) {
        orderService.placeOrder(orderDTO);
        return "placeOrder, haha";
    }
}
