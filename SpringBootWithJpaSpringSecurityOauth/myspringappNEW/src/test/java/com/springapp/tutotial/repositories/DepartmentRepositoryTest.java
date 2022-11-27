package com.springapp.tutotial.repositories;

import com.springapp.tutotial.models.Department;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
class DepartmentRepositoryTest {
    @Autowired
    private IDepartmentRepository departmentRepository;
    @Autowired
    private TestEntityManager testEntityManager;
    @BeforeEach
    void setUp() {
        Department department = Department.builder()
                .name("IT Helpdesk")
                .address("90210 Broadway Blvd, Nashville")
                .build();
        testEntityManager.persist(department);
    }
    @Test
    public void testFindDepartmentById() {
        //assertEquals("IT Helpdesk", departmentRepository.)
    }

    @AfterEach
    void tearDown() {
    }
}