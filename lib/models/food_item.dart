class FoodItem {
  final int id;
  final String name;
  final num price;
  final int delivery_time;
  final String description;
  final String imgUrl;
  final String status;
  final String categoryName;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.delivery_time,
    required this.description,
    required this.imgUrl,
    required this.status,
    required this.categoryName,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['_id'],
      name: json['name'],
      price: json['price'],
      delivery_time: json['delivery_time'],
      description: json['description'],
      imgUrl: json['img_url'],
      status: json['status'],
      categoryName: json['category']['name'],
    );
  }
}