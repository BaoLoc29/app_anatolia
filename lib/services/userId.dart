import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  Future<Map<String, dynamic>> getUserData(String userId) async {
    final response = await http.get(
      Uri.parse(
          'https://vutt94.io.vn/food_order/api/user/listOne/?id_user=$userId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['user'];
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
