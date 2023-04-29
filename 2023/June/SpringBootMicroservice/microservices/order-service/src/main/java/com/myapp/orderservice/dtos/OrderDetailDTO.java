package com.myapp.orderservice.dtos;
import lombok.*;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailDTO {
    private String productSkuCode;
    private BigDecimal price;
    private Integer quantity;
    // Other properties and methods
}
