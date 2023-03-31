package com.myapp.orderservice.models;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Min;
import java.math.BigDecimal;

@Entity
@Table(name = "order_details")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order order;

    @Column(name = "product_sku_code", length = 50, nullable = false)
    private String productSkuCode;

    @Column(name = "price", precision = 10, scale = 2, nullable = false)
    @DecimalMin(value = "0.00", inclusive = true, message = "Price must be greater than or equal to 0.00")
    private BigDecimal price;

    @Column(name = "quantity", nullable = false)
    @Min(value = 1, message = "Quantity must be greater than 0")
    private Integer quantity;
}
