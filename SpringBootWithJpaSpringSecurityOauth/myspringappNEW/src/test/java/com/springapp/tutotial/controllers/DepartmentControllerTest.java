package com.springapp.tutotial.controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.springapp.tutotial.models.Department;
import com.springapp.tutotial.services.DepartmentService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;


import static org.junit.jupiter.api.Assertions.*;
@WebMvcTest(DepartmentController.class)
class DepartmentControllerTest {
    @Autowired
    private MockMvc mockMvc;
    @MockBean
    private DepartmentService departmentService;


    @BeforeEach
    void setUp() {

    }
    private String toJSONString(Object object) {
        try {
            return new ObjectMapper().writer()
                    .withDefaultPrettyPrinter()
                    .writeValueAsString(object);
        } catch (Exception e) {
            System.out.println("Cannot convert to json string"+e.getMessage());
            return "";
        }
    }
    @Test
    void insertDepartment() throws Exception {
        Department newDepartment = Department.builder()
                .name("IT")
                .address("Hoan Kiem, Hanoi, Vietnam")
                .departmentId(2L)
                .build();
        mockMvc.perform(post("/departments")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(toJSONString(newDepartment))
                )
                .andExpect(status().isOk());
    }

    @Test
    void getDepartments() {
    }

    @Test
    void deleteDepartmentById() {
    }

    @Test
    void updateDepartment() {
    }

    @Test
    void findDepartmentByName() {
    }
}