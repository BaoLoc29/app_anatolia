import 'package:flutter/material.dart';
import 'package:food_app/pages/details.dart';
import 'package:food_app/services/food_item_api.dart'; // Import dịch vụ API
import 'package:food_app/models/food_item.dart';
import 'package:food_app/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = true, salad = false, burger = false;
  late Future<List<FoodItem>> foodItems;

  @override
  void initState() {
    super.initState();
    // Set the default category for demonstration.
    foodItems =
        FoodService().fetchFoodByCategory(1); // Example category ID 1 for pizza
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Hello Huy,",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {
              // Handle cart navigation
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Delicious Food", style: AppWidget.HeadlineTextFeildStyle()),
            Text("Discover and Get Great Food",
                style: AppWidget.LightTextFeildStyle()),
            SizedBox(height: 20),
            showItem(),
            SizedBox(height: 30),
            Expanded(
              child: FutureBuilder<List<FoodItem>>(
                future: foodItems,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No food items found.'));
                  } else {
                    final foodList = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: foodList.length,
                      itemBuilder: (context, index) {
                        final foodItem = foodList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Details(foodItem: foodItem),
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.only(bottom: 20.0),
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    foodItem.imgUrl,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 120,
                                        width: 120,
                                        color: Colors.grey,
                                        child: Icon(Icons.error),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          foodItem.name,
                                          style: AppWidget
                                              .semiBoldTextFeildStyle(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          foodItem.description,
                                          style:
                                              AppWidget.LightTextFeildStyle(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "\$${foodItem.price}",
                                          style: AppWidget
                                              .semiBoldTextFeildStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showItem() {
    return Container(
      height: 80, // Ensure a fixed height for the container
      child: SingleChildScrollView(
        scrollDirection:
            Axis.horizontal, // Scroll direction should be horizontal
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            categoryButton("pizza", "images/pizza.png", 1, pizza),
            categoryButton("icecream", "images/ice-cream.png", 2, icecream),
            categoryButton("salad", "images/salad.png", 4, salad),
            categoryButton("burger", "images/burger.png", 3, burger),
          ],
        ),
      ),
    );
  }

  Widget categoryButton(
      String label, String imagePath, int categoryId, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          icecream = false;
          pizza = false;
          salad = false;
          burger = false;
          switch (label) {
            case 'pizza':
              pizza = true;
              break;
            case 'icecream':
              icecream = true;
              break;
            case 'salad':
              salad = true;
              break;
            case 'burger':
              burger = true;
              break;
          }
          foodItems = FoodService().fetchFoodByCategory(categoryId);
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 20.0),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(8),
            child: Image.asset(
              imagePath,
              height: 55,
              width: 55,
              fit: BoxFit.cover,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
