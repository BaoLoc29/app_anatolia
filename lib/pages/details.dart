import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../widget/widget_support.dart'; // Đảm bảo rằng bạn đã định nghĩa các phong cách trong file này

class Details extends StatefulWidget {
  final FoodItem item;

  const Details({super.key, required this.item});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // Container bao quanh hình ảnh để tạo bo tròn
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Thay đổi giá trị theo yêu cầu
                // overflow: Overflow.clip, // Đảm bảo nội dung bên ngoài không bị lộ ra ngoài khung bo tròn
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Thay đổi giá trị theo yêu cầu
                child: Image.network(
                  widget.item.imgUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.categoryName, // Sử dụng dữ liệu thực tế
                      style: AppWidget.semiBoldTextFeildStyle(),
                    ),
                    Text(
                      widget.item.name,
                      style: AppWidget.HeadlineTextFeildStyle(),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_quantity > 1) {
                        _quantity--;
                      }
                    });
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
                  _quantity.toString(), // Số lượng món ăn
                  style: AppWidget.semiBoldTextFeildStyle(),
                ),
                SizedBox(width: 20.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _quantity++;
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
            SizedBox(height: 20.0),
            Text(
              widget.item.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppWidget.LightTextFeildStyle(),
            ),
            SizedBox(height: 30.0),
            Row(
              children: [
                Text(
                  'Delivery Time',
                  style: AppWidget.semiBoldTextFeildStyle(),
                ),
                SizedBox(width: 55.0),
                Icon(
                  Icons.alarm,
                  color: Colors.black54,
                ),
                SizedBox(width: 5.0),
                Text(
                  '${widget.item.delivery_time.toString()} min',
                  style: AppWidget.semiBoldTextFeildStyle(),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: AppWidget.semiBoldTextFeildStyle(),
                      ),
                      Text(
                        '\$${(widget.item.price * _quantity).toString()}', // Tính giá tổng theo số lượng
                        style: AppWidget.HeadlineTextFeildStyle(),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Add to cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(width: 30.0),
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
                        SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
