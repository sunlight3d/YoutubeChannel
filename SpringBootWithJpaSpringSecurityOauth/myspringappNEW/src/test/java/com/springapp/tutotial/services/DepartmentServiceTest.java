package com.springapp.tutotial.services;

import com.springapp.tutotial.models.Department;
import com.springapp.tutotial.repositories.IDepartmentRepository;
import org.junit.jupiter.api.*;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class DepartmentServiceTest {
    @Autowired
    private IDepartmentService departmentService;

    @MockBean
    private IDepartmentRepository departmentRepository;

    @BeforeEach
    void setUp() {
        //if you donot create department object, the test result is failed
        Department department = Department.builder()
                                .name("Sales")
                                .address("somewhere")
                                .build();
        Mockito.when(departmentRepository.findByNameIgnoreCase("sales"))
                .thenReturn(department);
    }

    @AfterEach
    void tearDown() {
    }

    @Test
    void getDepartments() {
    }
    @Test
    @DisplayName("Test fetch Department by name")
    //@Disabled //disable this function
    void testFetchDeparmentByName() {
        assertEquals("sales",
                            departmentService
                            .findDepartmentByName("sales")
                            .getName().toLowerCase());
    }
}