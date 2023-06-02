import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricLoginScreen extends StatefulWidget {
  @override
  _BiometricLoginScreenState createState() => _BiometricLoginScreenState();
}

class _BiometricLoginScreenState extends State<BiometricLoginScreen> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;

    try {
      authenticated = await _localAuthentication.authenticate(
        localizedReason: 'Quét vân tay để đăng nhập',
        options: const AuthenticationOptions(useErrorDialogs: true, stickyAuth: false)
      );
    } catch (e) {
      print(e);
    }

    if (authenticated) {
      print('Xác minh thành công');
      // Đăng nhập thành công, chuyển đến màn hình chính hoặc trang nào bạn cần
    } else {
      print('Xác minh thất bại');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập vân tay'),
      ),
      body: Center(
        // child: RaisedButton(
        //   onPressed: () {
        //     authenticateWithBiometrics();
        //   },
        //   child: Text('Đăng nhập bằng vân tay'),
        // ),
      ),
    );
  }
}
