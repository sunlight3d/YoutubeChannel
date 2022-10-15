module com.javafxdemo.javafxdemo {
    requires javafx.controls;
    requires javafx.fxml;

    requires org.kordamp.bootstrapfx.core;

    opens com.javafxdemo.javafxdemo to javafx.fxml;
    exports com.javafxdemo.javafxdemo;
}