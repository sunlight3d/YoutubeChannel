import models.BeanConfiguration;
import models.Klass;
import models.ShoppingCart;
import models.Student;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Main {
    public static void main(String[] args) {
        ApplicationContext applicationContext = new
                AnnotationConfigApplicationContext(BeanConfiguration.class);
        Student studentA = applicationContext.getBean(Student.class);
        Student studentB = applicationContext.getBean(Student.class);
        //studentA and studentB has the same "memory address"
        studentA.setName("Hoang");
        Klass klass = applicationContext.getBean(Klass.class);

        ShoppingCart shoppingCart = applicationContext.getBean(ShoppingCart.class);
        shoppingCart.checkout("cancelled");
    }
}
