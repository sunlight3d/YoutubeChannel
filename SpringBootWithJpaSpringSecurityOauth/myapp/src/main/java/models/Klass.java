package models;

import org.springframework.stereotype.Component;
@Component
public class Klass {
    private String name;

    //default constructor
    public Klass() {}
    public Klass(String name) {
        //this is a constructor
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "klass's name: "+this.name;
    }
}
