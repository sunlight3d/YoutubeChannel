package com.myapp.orderservice.repositories;

import com.myapp.orderservice.models.Order;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<Order, Long> {

}
