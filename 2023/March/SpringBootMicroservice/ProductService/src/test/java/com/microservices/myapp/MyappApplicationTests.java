package com.microservices.myapp;

import com.microservices.myapp.dtos.ProductDTO;
import com.microservices.myapp.repositories.ProductRepository;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.testcontainers.containers.MongoDBContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;
import org.testcontainers.shaded.com.fasterxml.jackson.databind.ObjectMapper;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
@RunWith(SpringRunner.class)
@Testcontainers
//@AutoConfigureMockMvc
@SpringBootTest
class MyappApplicationTests {
	@Container
	static MongoDBContainer mongoDBContainer = new
			MongoDBContainer("mongo:jammy");
	@Autowired
	private MockMvc mockMvc;
	@Autowired
	private ObjectMapper objectMapper;
	@DynamicPropertySource
	static void setProperties(DynamicPropertyRegistry dynamicPropertyRegistry) {
		dynamicPropertyRegistry.add("spring.data.mongodb.uri", mongoDBContainer::getReplicaSetUrl);
	}
	@Test
	void testInsertProduct() throws Exception{
		ProductDTO productDTO = ProductDTO.builder()
				.name("iphone 16")
				.description("This is my dream")
				.price(2000)
				.build();
		mockMvc.perform(MockMvcRequestBuilders.post("http://localhost:8080/api/products")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(productDTO)))
				.andExpect(status().isCreated());
	}
	@Test
	void contextLoads() {
	}
	@Configuration
	static class TestConfig {
		@Bean
		public ObjectMapper objectMapper() {
			return new ObjectMapper();
		}
	}

}
