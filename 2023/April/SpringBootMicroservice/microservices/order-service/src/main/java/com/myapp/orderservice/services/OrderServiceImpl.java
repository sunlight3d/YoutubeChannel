package com.myapp.orderservice.services;

import com.myapp.orderservice.dtos.OrderDTO;
import com.myapp.orderservice.dtos.OrderDetailDTO;
import com.myapp.orderservice.models.Order;
import com.myapp.orderservice.models.OrderDetail;
import com.myapp.orderservice.repositories.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService{
    private final OrderRepository orderRepository;
    @Override
    public void placeOrder(OrderDTO orderDTO) {
        Order newOrder = Order.builder()
                .orderNumber(UUID.randomUUID().toString())
                .build();
        List<OrderDetailDTO> orderDetailDTOs = orderDTO.getOrderDetails();
        List<OrderDetail> orderDetails = (List<OrderDetail>)orderDetailDTOs.stream()
                .map(orderDetailDTO -> OrderDetail.builder()
                        .price(orderDetailDTO.getPrice())
                        .quantity(orderDetailDTO.getQuantity())
                        .productSkuCode(orderDetailDTO.getProductSkuCode()).build()).toList();
        newOrder.setOrderDetails(orderDetails);
        orderRepository.save(newOrder);
    }
}
