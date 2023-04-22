import 'package:flutter/material.dart';
import 'package:flutterapp/services/user_service.dart';
import 'package:flutterapp/services/watchlist_service.dart';

class ApiProvider with ChangeNotifier {
  final UserService _userService = UserService(baseUrl: "https://localhost:1234");
  final WatchListService _watchListService = WatchListService(baseUrl: "https://localhost:1234");
  UserService get userService => _userService;
  WatchListService get watchListService => _watchListService;
}
