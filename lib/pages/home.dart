import 'package:flutter/material.dart';
import 'package:food_app/pages/details.dart';
import 'package:food_app/services/food_service.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = false, salad = false, burger = false;
  late Future<List<FoodItem>> futureFoodItems;
  int selectedCategoryId = 1; // Default category ID

  @override
  void initState() {
    super.initState();
    futureFoodItems = FoodService().fetchFoodByCategory(selectedCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hello Huy, ", style: AppWidget.boldTextFeildStyle()),
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8)),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Text("Delicious Food", style: AppWidget.HeadlineTextFeildStyle()),
            Text("Discover and Get Great Food", style: AppWidget.LightTextFeildStyle()),
            SizedBox(height: 20.0),
            Container(margin: EdgeInsets.only(right: 20.0), child: showItem()),
            SizedBox(height: 30.0),
            Expanded(
              child: FutureBuilder<List<FoodItem>>(
                future: futureFoodItems,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Error fetching food items: ${snapshot.error}');
                    return Center(child: Text('Error fetching food items: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No food items found.'));
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: snapshot.data!.map((foodItem) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Details(item: foodItem),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(4),
                              child: Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        foodItem.imgUrl,
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(foodItem.name, style: AppWidget.semiBoldTextFeildStyle()),
                                      SizedBox(height: 5.0),
                                      Text(foodItem.description, style: AppWidget.LightTextFeildStyle()),
                                      SizedBox(height: 5.0),
                                      Text("\$${foodItem.price}", style: AppWidget.semiBoldTextFeildStyle()),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 60.0),
            Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/salad2.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Mediterranean Chickpea Salad",
                              style: AppWidget.semiBoldTextFeildStyle(),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Honey goat cheese",
                              style: AppWidget.LightTextFeildStyle(),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "\$28",
                              style: AppWidget.semiBoldTextFeildStyle(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        categoryButton("Ice Cream", "images/ice-cream.png", 2, icecream),
        categoryButton("Pizza", "images/pizza.png", 1, pizza),
        categoryButton("Salad", "images/salad.png", 4, salad),
        categoryButton("Burger", "images/burger.png", 3, burger),
      ],
    );
  }

  Widget categoryButton(String label, String imagePath, int categoryId, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          icecream = categoryId == 2;
          pizza = categoryId == 1;
          salad = categoryId == 4;
          burger = categoryId == 3;
          selectedCategoryId = categoryId;
          futureFoodItems = FoodService().fetchFoodByCategory(selectedCategoryId);
        });
      },
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
              color: isSelected ? Colors.orange : Colors.white,
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(8),
          child: Image.asset(
            imagePath,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
