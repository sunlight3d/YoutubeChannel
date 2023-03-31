package com.myapp.orderservice.dtos;
import lombok.*;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDTO {
    private List<OrderDetailDTO> orderDetails;
}
