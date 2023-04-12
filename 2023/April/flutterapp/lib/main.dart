import 'package:flutter/material.dart';
import 'package:flutterapp/screens/home/home.dart';
import 'package:flutterapp/screens/settings/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      //home: SettingsScreen()
    );
  }
}