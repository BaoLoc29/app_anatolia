import 'food_item.dart';

class CartItem {
  final FoodItem food;
  final int amount;
  final double price;

  CartItem({required this.food, required this.amount, required this.price});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      food: FoodItem.fromJson(json['food']),
      amount: json['amount'],
      price: (json['price'] as num).toDouble(), // Chuyển đổi số thành double
    );
  }
}
