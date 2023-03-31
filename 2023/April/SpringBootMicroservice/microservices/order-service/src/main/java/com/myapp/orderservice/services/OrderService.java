package com.myapp.orderservice.services;

import com.myapp.orderservice.dtos.OrderDTO;
import com.myapp.orderservice.repositories.OrderRepository;
import lombok.RequiredArgsConstructor;


public interface OrderService {
    public void placeOrder(OrderDTO orderDTO);
}
