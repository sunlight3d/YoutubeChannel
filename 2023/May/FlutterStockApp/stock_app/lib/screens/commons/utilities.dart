import 'package:flutter/material.dart';

enum AlertType { error, warning, info }

void alert(BuildContext context, String message, AlertType type) {
  IconData icon;
  Color color;

  switch (type) {
    case AlertType.error:
      icon = Icons.error;
      color = Colors.red;
      break;
    case AlertType.warning:
      icon = Icons.warning;
      color = Colors.yellow;
      break;
    case AlertType.info:
      icon = Icons.info;
      color = Colors.blue;
      break;
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Icon(icon, color: color),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          )
        ],
      );
    },
  );

}
