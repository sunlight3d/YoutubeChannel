package com.springapp.tutotial.models;

import lombok.*;
import org.hibernate.validator.constraints.Length;
import org.springframework.jmx.export.annotation.ManagedAttribute;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
//Now we change from H2 -> MySQL
//You can install mysql using XAMPP or Docker(in my Youtube channel)
//for simpler, I use XAMPP
public class Department {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "departmentId",//name in database
            nullable = false)
    private long departmentId;
    @NotBlank(message = "You must enter department's name")
    @Length(max = 100, min = 3)
    private String name;//findByName
    private String address;//findByAddress

}
