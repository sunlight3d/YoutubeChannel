package com.springapp.tutotial.controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
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
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import static org.junit.jupiter.api.Assertions.*;
@WebMvcTest(DepartmentController.class)
class DepartmentControllerTest {
    @Autowired
    private MockMvc mockMvc;
    @MockBean
    private DepartmentService departmentService;

    //private Department department;

    @BeforeEach
    void setUp() {

    }
    private String toJSONString(Object object) {
        try {
//            return new ObjectMapper()
//                    //.withDefaultPrettyPrinter()
//                    .writeValueAsString(object);
            Gson gson = new Gson();
            return gson.toJson(Department.class);
        } catch (Exception e) {
            System.out.println("Cannot convert to json string"+e.getMessage());
            return "";
        }
    }
    @Test
    void insertDepartment() throws Exception {
        Department updatedDepartment = Department.builder()
                .name("Sales")
                .address("somewhere")
                .departmentId(1L)
                .build();
        mockMvc.perform(MockMvcRequestBuilders.post("/departments")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\n" +
                        "    \"name\": \"Sales\", \n" +
                        "    \"address\": \"Bachmai street, Hanoi\"\n" +
                        "}")
                )
                .andExpect(MockMvcResultMatchers.status().isOk());
    }

    @Test
    void getDepartments() {
    }

    @Test
    void getDepartmentById() {
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