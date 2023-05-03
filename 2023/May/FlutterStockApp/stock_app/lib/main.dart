import 'package:flutter/material.dart';
import 'package:stock_app/screens/login/login.dart';
import 'package:stock_app/screens/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',       //home: SplashScreen(),
      home: LoginScreen(),
    );
  }
}

