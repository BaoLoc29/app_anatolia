import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/food_item.dart';
import '../services/cart_api.dart';
import '../widget/widget_support.dart';

class Order extends StatefulWidget {
  final FoodItem? item;
  final int? quantity;

  const Order({super.key, this.item, this.quantity});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final CartService cartService = CartService();
  late Future<List<CartItem>> futureCart;

  @override
  void initState() {
    super.initState();
    if (widget.item != null && widget.quantity != null) {
      cartService.addToCart(widget.item!, widget.quantity!);
    }
    futureCart = cartService.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            Material(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Center(
                  child: Text(
                    "Food Cart",
                    style: AppWidget.HeadlineTextFeildStyle(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            FutureBuilder<List<CartItem>>(
              future: futureCart,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No items in the cart.'));
                } else {
                  final cartItems = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(child: Text("${item.amount}")),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.network(item.food.imgUrl,
                                          height: 90, width: 90)),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.food.name,
                                        style: AppWidget.semiBoldTextFeildStyle(),
                                      ),
                                      Text(
                                        '\$${item.price}',
                                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
