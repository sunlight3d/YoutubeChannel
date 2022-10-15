package com.javafxdemo.javafxdemo;

import javafx.fxml.FXML;
import javafx.scene.control.Label;

public class HelloController {
    @FXML
    private Label txtTitle;

    @FXML
    protected void onHelloButtonClick() {
        txtTitle.setText("ok, you pressed");
    }
}