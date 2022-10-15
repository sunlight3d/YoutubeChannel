package com.javafxdemo.javafxdemo;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

public class MyApp extends Application {
    @Override
    public void start(Stage stage) throws IOException {
        Scene loginScene = new Scene(new FXMLLoader(MyApp.class.getResource("login.fxml")).load(),
                320, 240);
        stage.setTitle("This is MyApp");
        stage.setScene(loginScene);
        stage.show();
    }

    public static void main(String[] args) {
        launch();
    }
}