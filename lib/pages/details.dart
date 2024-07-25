import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/widget/widget_support.dart';

class Details extends StatefulWidget {
  final FoodItem foodItem;

  const Details({super.key, required this.foodItem});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final foodItem = widget.foodItem;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
            foodItem.imgUrl != null && foodItem.imgUrl!.isNotEmpty
                ? Image.network(
                    foodItem.imgUrl!,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    color: Colors.grey,
                    child: Icon(
                      Icons.image_not_supported,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        foodItem.name ?? 'Unknown',
                        style: AppWidget.HeadlineTextFeildStyle(),
                      ),
                      Text(
                        foodItem.description ?? 'No description available',
                        style: AppWidget.boldTextFeildStyle(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        quantity.toString(),
                        style: AppWidget.semiBoldTextFeildStyle(),
                      ),
                      SizedBox(width: 20.0),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // SizedBox(height: 20.0),
            // Text(
            //   foodItem.description ?? 'No description available',
            //   maxLines: 3,
            //   overflow: TextOverflow.ellipsis,
            //   style: AppWidget.LightTextFeildStyle(),
            // ),
            SizedBox(height: 30.0),
            Row(
              children: [
                Text(
                  "Delivery Time",
                  style: AppWidget.semiBoldTextFeildStyle(),
                ),
                SizedBox(width: 25.0),
                Icon(
                  Icons.alarm,
                  color: Colors.black54,
                ),
                SizedBox(width: 5.0),
                Text(
                  "${foodItem.deliveryTime.toString()} min",
                  style: AppWidget.semiBoldTextFeildStyle(),
                )
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price",
                        style: AppWidget.semiBoldTextFeildStyle(),
                      ),
                      Text(
                        "\$${(foodItem.price ?? 0) * quantity}",
                        style: AppWidget.HeadlineTextFeildStyle(),
                      ),
                    ],
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // handle add to cart action
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 20.0), // Adjust padding for button size
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content horizontally
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Center the content vertically
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Distribute space between text and icon
                                children: [
                                  Text(
                                    "Add to cart",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
