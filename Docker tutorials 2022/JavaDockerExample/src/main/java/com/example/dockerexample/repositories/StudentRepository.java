package com.example.dockerexample.repositories;

import com.example.dockerexample.models.Student;
import org.springframework.data.repository.CrudRepository;

//Inject this repository to controller
public interface StudentRepository
        extends CrudRepository<Student, Integer> {

}
