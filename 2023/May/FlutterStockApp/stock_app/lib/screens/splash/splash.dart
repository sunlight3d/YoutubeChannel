import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/screens/home/home.dart';
import 'package:stock_app/screens/login/login.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      checkLoginStatus(context);
    });
  }
  Future<void> checkLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    await Future.delayed(const Duration(seconds: 1));
    if (isLoggedIn) {
      // Đã đăng nhập, chuyển sang màn hình HomeScreen
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } else {
      // Chưa đăng nhập, chuyển sang màn hình LoginScreen
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo.png',),
                      )
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                //"This is splash,x = ${this.x}",
                'This is splash',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}