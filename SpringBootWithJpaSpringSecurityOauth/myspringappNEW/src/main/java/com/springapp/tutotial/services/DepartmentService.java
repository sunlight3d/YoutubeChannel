package com.springapp.tutotial.services;

import com.springapp.tutotial.exceptions.DepartmentNotFoundException;
import com.springapp.tutotial.models.Department;
import com.springapp.tutotial.repositories.IDepartmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class DepartmentService implements IDepartmentService{
    //service access "repository"
    @Autowired
    private IDepartmentRepository departmentRepository;

    @Override
    public Department insertDepartment(Department department) {
        return departmentRepository.save(department);
    }

    @Override
    public List<Department> getDepartments() {
        return departmentRepository.findAll();
    }

    @Override
    public Department getDepartmentById(Long departmentId)
        throws DepartmentNotFoundException{
        Optional<Department> department = departmentRepository
                                            .findById(departmentId);
        if(department.isPresent()) {
            return department.get();
        } else {
            throw new DepartmentNotFoundException("Department not Found");
        }

    }

    @Override
    public void deleteDepartmentById(Long departmentId) {
        departmentRepository.deleteById(departmentId);
    }

    @Override
    public Department updateDepartment(Long departmentId, Department department) {
        Optional<Department> existedDepartment = departmentRepository
                                        .findById(departmentId);
        if(existedDepartment.isPresent()) {
            boolean isValidName = Objects.nonNull(department.getName()) &&
                    !department.getName().trim().equalsIgnoreCase("");
            if(isValidName) {
                existedDepartment.get().setName(department.getName());
            }
            boolean isValidAddress = Objects.nonNull(department.getAddress()) &&
                    !department.getAddress().trim().equalsIgnoreCase("");
            if(isValidAddress) {
                existedDepartment.get().setAddress(department.getAddress());
            }
            return departmentRepository.save(existedDepartment.get());
        }
        return null;
    }

    @Override
    public Department findDepartmentByName(String departmentName) {
        return departmentRepository.findByNameIgnoreCase(departmentName);
    }
}
