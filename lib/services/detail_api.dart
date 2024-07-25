import 'package:http/http.dart' as http;
import 'dart:convert';

class FoodService {
  final String baseUrl = 'https://vutt94.io.vn/food_order/api/food/listOne/';

  Future<Map<String, dynamic>> fetchFoodDetail(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl?id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load food detail');
    }
  }
}
