import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart_item.dart';
import '../models/food_item.dart';

class CartService {
  final String _baseUrl = 'https://vutt94.io.vn/food_order/api/cart'; // URL cơ bản của API

  Future<void> addToCart(FoodItem item, int quantity) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/addItem'), // Đảm bảo URL này đúng với API của bạn
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'itemId': item.id.toString(),
        'amount': quantity.toString(),
        'price': item.price.toString(),
      },
    );

    if (response.statusCode != 200) {
      final errorMessage = json.decode(response.body)['message'] ?? 'Unknown error';
      throw Exception('Failed to add item to cart: $errorMessage');
    }
  }

  Future<List<CartItem>> getCart() async {
    final response = await http.get(Uri.parse('$_baseUrl/getCart'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Kiểm tra dữ liệu JSON
      if (jsonData is Map<String, dynamic> && jsonData.containsKey('data')) {
        final data = jsonData['data'];
        if (data is Map<String, dynamic> && data.containsKey('cartItem')) {
          List<dynamic> cartData = data['cartItem'];
          return cartData.map((item) => CartItem.fromJson(item)).toList();
        } else {
          throw Exception('Key "cartItem" not found in JSON data');
        }
      } else {
        throw Exception('Key "data" not found in JSON');
      }
    } else {
      throw Exception('Failed to load cart');
    }
  }
}
