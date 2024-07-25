import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'https://vutt94.io.vn/food_order/api/user';

  Future<bool> logout() async {
    final url = Uri.parse('$_baseUrl/logout');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['status'] == 0;
      } else {
        return false;
      }
    } catch (e) {
      print('Error during logout: $e');
      return false;
    }
  }
}
