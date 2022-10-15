package com.javafxdemo.javafxdemo.controllers;

import javafx.fxml.FXML;
import javafx.scene.control.Label;

public class LoginController {
    @FXML
    private Label txtTitle;

    @FXML
    protected void onHelloButtonClick() {
        txtTitle.setText("ok, something changed");
    }
}