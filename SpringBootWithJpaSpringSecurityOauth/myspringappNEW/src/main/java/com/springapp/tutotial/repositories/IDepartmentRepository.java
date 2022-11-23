package com.springapp.tutotial.repositories;

import com.springapp.tutotial.models.Department;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IDepartmentRepository
        extends JpaRepository<Department, Long> {
    //<"Model's name", "Id' type">
    public Department findByNameIgnoreCase(String departmentName);
}
