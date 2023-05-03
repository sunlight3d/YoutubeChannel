import 'package:flutter/material.dart';

class PasswordValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 3) {
      return 'Password must be at least 3 characters';
    } else if (!value.contains(RegExp(r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{3,}$'))) {
      return 'Password must contain at least 1 letter and 1 number';
    }
    return null;
  }
}