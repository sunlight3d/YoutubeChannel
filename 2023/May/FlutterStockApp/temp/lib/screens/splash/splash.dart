import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/home/home.dart';
import 'dart:math';

import 'package:flutterapp/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*
Xây dựng một màn hình khởi động trong Flutter:
-Có ảnh background làm nền
-Ở giữa ảnh là 1 cái logo
-Bao ngoài ảnh là 1 cài vòng tròn(xoay vòng thể hiện loading)
-Ảnh logo ở tâm vòng tròn
* */
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
    Timer(Duration(seconds: 2), () {
      checkLoginStatus(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }
  void checkLoginStatus(BuildContext context) async {
    // Lấy SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Lấy trạng thái đăng nhập
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      // Đã đăng nhập, chuyển sang màn hình HomeScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Chưa đăng nhập, chuyển sang màn hình LoginScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          )),
          Center(child: AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(
                angle: _animationController.value * 2 * pi,
                child: child!,
              );
            },
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
              ),
            ),
          ),)
        ],
      ),
    );
  }
}
/*
Viết cho tôi màn hình Login trong Flutter
-Nền là 1 ảnh
-Logo nằm trên top, căn giữa màn hình
-TextField "Customer ID", nền trắng, logo user nằm trong Text field, bên trái, padding 10
-TextField "Password", nền trắng, logo user nằm trong Text field, bên trái, padding 10, logo "đôi mắt" ở phía bên phải, bấm vào sẽ hiện password
-Khi nhập thông tin thì customer id và password được lưu vào state
-Row chứa nút "Login", bên cạnh Login là nút "vân tay", row này căn giữa
-Row kế tiếp là dòng chữ màu trắng: Don't have an account yet?, sau đó dòng chữ màu xanh: Open account, yêu cầu cấp quyền camera
-Tiếp theo là nút "Get smart OTP", nền trong suốt, border màu trắng


* */

