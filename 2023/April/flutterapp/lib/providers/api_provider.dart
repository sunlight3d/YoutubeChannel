import 'package:flutter/material.dart';
import 'package:flutterapp/services/user_service.dart';

class ApiProvider with ChangeNotifier {
  final UserService _userService = UserService();
  UserService get userService => _userService;
}
