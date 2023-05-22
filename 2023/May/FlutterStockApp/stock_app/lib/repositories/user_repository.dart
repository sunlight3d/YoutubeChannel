import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:stock_app/repositories/api.dart';
import 'dart:convert' as convert;

class UserRepository {

  static Future<String?> login(String email, String password) async {
    final url = Uri.parse('${Api.baseUrl}/user/login');
    final body = jsonEncode({
      'email': email,
      'password': password,
    });
    final response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'] as String?;
      return token;
    } else {
      throw Exception('Failed to login');
    }
  }

  static bool isTokenValid(String? jwtToken) {
    if (jwtToken == null || jwtToken.isEmpty) {
      return false;
    }
    Map<String, dynamic> payload = Jwt.parseJwt(jwtToken);
    //print(payload['email']);
    DateTime? expiryDate = Jwt.getExpiryDate(jwtToken);
    print(expiryDate);
    // To check if token is expired
    return Jwt.isExpired(jwtToken);
  }
}
