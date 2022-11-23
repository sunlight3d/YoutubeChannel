package com.springapp.tutotial.controllers;

import com.springapp.tutotial.exceptions.DepartmentNotFoundException;
import com.springapp.tutotial.models.Department;
import com.springapp.tutotial.repositories.IDepartmentRepository;
import com.springapp.tutotial.services.IDepartmentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/departments")
public class DepartmentController {
    private final Logger log
            = LoggerFactory.getLogger(Department.class);
    @Autowired
    private IDepartmentService departmentService;

    @PostMapping()
    public Department insertDepartment(
            @Valid @RequestBody Department department) {
        log.info("before insert department");
        return departmentService.insertDepartment(department);
    }
    @GetMapping()
    public List<Department> getDepartments() {
        log.info("before getDepartments");
        return departmentService.getDepartments();
    }

    @GetMapping("{id}")
    public Department getDepartmentById(@PathVariable("id") Long departmentId)
        throws DepartmentNotFoundException {
        return departmentService.getDepartmentById(departmentId);
    }
    @DeleteMapping("{id}")
    public String deleteDepartmentById(@PathVariable("id") Long departmentId) {
        departmentService.deleteDepartmentById(departmentId);
        return "Delete department successfully";
    }
    @PutMapping("{id}") //departments/{id}
    public Department updateDepartment(
            @PathVariable("id") Long departmentId,
            @RequestBody Department department
    ) {
        return departmentService.updateDepartment(departmentId, department);
    }
    //find departments by name
    @GetMapping("name/{name}")
    public Department findDepartmentByName(
            @PathVariable("name") String departmentName
    ) {
        return departmentService.findDepartmentByName(departmentName);
    }
}
