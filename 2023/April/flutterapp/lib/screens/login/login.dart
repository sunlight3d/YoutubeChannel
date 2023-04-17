import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _customerID = '';
  String _password = '';
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent, //cho phép sự kiện chạm được truyền xuống cho các widget bên dưới
        onTap: () {
          // Đóng bàn phím
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 40),
              _buildTextField(
                hintText: 'Customer ID',
                icon: Icons.person,
                onChanged: (value) {
                  setState(() {
                    _customerID = value;
                  });
                },
              ),
              SizedBox(height: 20),
              _buildTextField(
                hintText: 'Password',
                icon: Icons.lock,
                obscureText: !_showPassword,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('Login'),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', true);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.fingerprint),
                    onPressed: () {

                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account yet?',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    child: Text(
                      'Open account',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(
                  'Get smart OTP',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Function(String)? onChanged,
    Widget? suffixIcon,
  }) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
              obscureText: obscureText,
              onChanged: onChanged,
            ),
          ),
          if (suffixIcon != null) suffixIcon,
        ],
      ),
    );
  }
}
