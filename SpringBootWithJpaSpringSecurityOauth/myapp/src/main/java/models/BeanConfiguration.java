package models;

import org.springframework.context.annotation.*;

@Configuration
@ComponentScan()
@EnableAspectJAutoProxy
public class BeanConfiguration {
    @Bean
    public Student student() {
        return new Student();
    }
    @Bean
    public Klass klass() {
        return new Klass();
    }
}
