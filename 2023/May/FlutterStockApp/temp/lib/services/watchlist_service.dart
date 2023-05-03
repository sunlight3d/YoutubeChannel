// lib/services/watch_list_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class WatchListService {
  final String baseUrl;
  WatchListService({required this.baseUrl});
  Future<bool> addToWatchlist(int stockId, String token) async {
    final String apiUrl = '$baseUrl/watchlist/add';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', // Gửi token trong header
        },
        body: jsonEncode(<String, int>{
          'stockId': stockId,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['success'];
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return false;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return false;
    }
  }
}
