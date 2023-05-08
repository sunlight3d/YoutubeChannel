import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/screens/commons/utilities.dart';
import 'package:stock_app/screens/home/home.dart';
import 'package:stock_app/validators/EmailValidator.dart';
import 'package:stock_app/validators/PasswordValidator.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;//this is a state
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _login() async{
    //alert(context, 'You pressed Login', AlertType.info);
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      //alert(context, 'Login successfully', AlertType.info);
      if(context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } else {
      alert(context, 'Login failed', AlertType.error);
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),

            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 20,),
                  _buildTextField(
                    hintText: 'Enter your email',
                    iconData: Icons.person,
                    controller: _emailController,
                    validator: EmailValidator.validate,
                  ),
                  const SizedBox(height: 20,),
                  _buildTextField(
                      hintText: 'Enter your password',
                      iconData: Icons.person,
                      obscureText: !_showPassword,
                      controller: _passwordController,
                      validator: PasswordValidator.validate,
                      suffixIcon:IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword  = !_showPassword;
                            });
                          },

                          icon: _showPassword ?
                          const Icon(Icons.visibility) :
                          const Icon(Icons.visibility_off)
                      )),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: _login,
                          child: Text('Login')
                      ),
                      IconButton(onPressed: null, icon: Icon(Icons.fingerprint)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account ?',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      TextButton(
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.greenAccent, fontSize: 16),
                        ),
                        onPressed: () {

                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Get smart OTP'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white,
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _buildTextField({
    required String hintText,
    required IconData iconData,
    Function(String)? onChanged,
    Widget? suffixIcon,
    bool obscureText = false,
    required TextEditingController controller,
    String? Function(String?)? validator
  }) {
    return  Container(
      width: MediaQuery.of(context).size.width-50,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          const SizedBox(width: 5,),
          Icon(iconData),
          const SizedBox(width: 5,),
          Expanded(child: TextFormField(
            decoration: InputDecoration(
                hintText: hintText,
            ),
            controller: controller,
            onChanged: onChanged,
            obscureText: obscureText,
            validator: validator,
          )),
          if(suffixIcon != null) suffixIcon
        ],
      ),
    );
  }
}