import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String _baseUrl = 'YOUR_API_BASE_URL'; // Thay thế bằng URL cơ sở của API của bạn

  Future<String> login(String email, String password, String deviceId) async {
    final String loginUrl = '$_baseUrl/login'; // Thay thế 'login' bằng đường dẫn đúng đến API đăng nhập của bạn
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'Email': email,
          'Password': password,
          'DeviceId': deviceId,
        },
      ),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['token'];
    } else {
      throw Exception('Failed to log in');
    }
  }
}
