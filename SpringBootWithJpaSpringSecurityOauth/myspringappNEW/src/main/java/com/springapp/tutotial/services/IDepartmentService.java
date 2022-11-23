package com.springapp.tutotial.services;


import com.springapp.tutotial.exceptions.DepartmentNotFoundException;
import com.springapp.tutotial.models.Department;

import java.util.List;

public interface IDepartmentService { //"I" stands for "interface"
    //service can call "repositories" to do taskA(insert data to DB),
    //taskB(query data in DB),...
    Department insertDepartment(Department department);
    List<Department> getDepartments();
    Department getDepartmentById(Long departmentId)
            throws DepartmentNotFoundException;
    void deleteDepartmentById(Long departmentId);
    Department updateDepartment(Long departmentId, Department department);
    Department findDepartmentByName(String departmentName);
}
