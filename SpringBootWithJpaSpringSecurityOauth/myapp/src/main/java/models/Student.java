package models;

import org.springframework.beans.factory.BeanNameAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

@Component
@Scope(scopeName = "singleton")
public class Student implements BeanNameAware {
    private String name;
    private String email;
    private int age;
    //the "student" is studying in a "class"
    private Klass klass;

    public Klass getKlass() {
        return klass;
    }

    public void setKlass(Klass klass) {
        this.klass = klass;
    }

    public void doSomething() {
        System.out.println("I am doing something...");
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    @Override
    public String toString() {
        return "models.Student's detail: " +
                "name='" + name + '\n' +
                ", email='" + email + '\n' +
                ", age=" + age;
    }

    @Override
    public void setBeanName(String beanName) {
        System.out.println("setBeanName is called");
    }
    @PostConstruct
    public void postConstruct() {
        System.out.println("postConstruct is called");
    }
}
