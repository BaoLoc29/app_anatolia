import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food_item.dart';

class FoodService {
  final String apiUrl =
      "https://vutt94.io.vn/food_order/api/food/listByCategory/";

  Future<List<FoodItem>> fetchFoodByCategory(int categoryId) async {
    final url = '$apiUrl$categoryId'; // Correct URL format
    print('Request URL: $url'); // Debugging line

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print('API response: $jsonResponse'); // Debugging line

      final List<dynamic> data = jsonResponse['data']['food'];
      return data.map((item) => FoodItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load food');
    }
  }
}
