library splash_screen_package;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  final Function(BuildContext context) checkLoginStatus; 
  SplashScreen({Key? key, required this.checkLoginStatus}) 
    : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () => checkLoginStatus(context));
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