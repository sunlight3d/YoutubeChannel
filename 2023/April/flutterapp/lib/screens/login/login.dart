import 'package:flutter/material.dart';
import 'package:flutterapp/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*
Viết code màn hình đăng nhập như sau:
- Logo ở phía trên, căn giữa màn hình
- TextField có nền trắng, icon căn trái,cho nhập customer id, bên phải là biểu tượng x, cho phép clear text
- TextField có nền trắng, icon căn trái,cho nhập customer id, bên phải là biểu tượng eye, bấm vào show/hide password
-Dưới textfield là Text "Forgot password", bấm vào sẽ hiện ra màn hình Forgot Password(màn hình di chuyển từ dưới lên trên)

- Thêm 4 button phía cuối màn hình, khi bàn phím hiện ra thì 4 nút này giữ nguyên vị trí
Button 1: icon ở trên, Text ở dưới(Terms of use)
Button 2: icon ở trên, Text ở dưới(Risk Notice)
Button 3: icon ở trên, Text ở dưới(Contact)
Button 4: icon ở trên, Text ở dưới(User Guide)

*/
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _customerID = '';
  String _password = '';
  bool _showPassword = false;

  void _login() async {
    try {
      UserService userService = UserService();
      String token = await userService.login(_customerID, _password, 'device123');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('token', token);
      // Chuyển đến màn hình tiếp theo sau khi đăng nhập thành công
      // Ví dụ: Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print('Error: $e');
      // Hiển thị thông báo lỗi cho người dùng
    }
  }
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
        child: Stack(
          children: [
            Container(
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
                        onPressed: _login,
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
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.description),
                          ),
                          Text(
                            'Terms of use',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.warning),
                          ),
                          Text(
                            'Risk Notice',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.phone),
                          ),
                          Text(
                            'Contact',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.help_outline),
                          ),
                          Text(
                            'User Guide',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
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
