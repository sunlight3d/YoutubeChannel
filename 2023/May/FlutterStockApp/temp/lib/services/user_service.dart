import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl;
  UserService({required this.baseUrl});
  Future<String> login(String email, String password, String deviceId) async {
    final String loginUrl = '$baseUrl/login';
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
