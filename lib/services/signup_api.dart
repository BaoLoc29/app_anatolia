import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String _baseUrl =
      'https://vutt94.io.vn/food_order/api/user/register';

  static Future<Map<String, dynamic>> signUp(
      String name, String email, String phone, String password) async {
    final url = Uri.parse(_baseUrl);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }
}
