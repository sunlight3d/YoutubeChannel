import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  // final int x;
  // Splash({required this.x});
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
