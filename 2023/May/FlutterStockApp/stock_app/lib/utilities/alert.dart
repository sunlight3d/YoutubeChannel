import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum AlertType { WARNING, ERROR, INFO }

void alert(BuildContext context, String message, AlertType type) {
  Color backgroundColor;
  Color textColor;
  switch (type) {
    case AlertType.WARNING:
      backgroundColor = Colors.yellow;
      textColor = Colors.black;
      break;
    case AlertType.ERROR:
      backgroundColor = Colors.red;
      textColor = Colors.white;
      break;
    case AlertType.INFO:
      backgroundColor = Colors.blue;
      textColor = Colors.white;
      break;
  }
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0);
}
