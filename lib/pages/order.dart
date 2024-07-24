import 'package:flutter/material.dart';
import 'package:food_app/widget/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
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
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    // 
                    children: [
                      Container(
                        height: 70,
                        width: 30,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text("2")),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.asset("images/food.jpg",
                              height: 90, width: 90)),
                      Column(
                        children: [
                          Text("Pizza", style: AppWidget.semiBoldTextFeildStyle(),)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
