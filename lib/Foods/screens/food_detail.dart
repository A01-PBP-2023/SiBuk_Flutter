import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sibuk_mobile/Foods/models/food.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dart_casing/dart_casing.dart';
import 'package:sibuk_mobile/Base/back_btn.dart';
import 'package:sibuk_mobile/Base/fav_status.dart';
import 'package:sibuk_mobile/main.dart';
import 'dart:async';

class FoodDetail extends StatefulWidget {
  const FoodDetail({super.key, required this.food, required this.isFavorited});
  final Food food;
  final bool isFavorited;

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0, 134, 47, 1),
        ),
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.asset(
                    (widget.food.fields.category == "Nasi"
                        ? "assets/images/category_icon/rice_icon.png"
                        : widget.food.fields.category == "Mie"
                            ? "assets/images/category_icon/noodle_icon.png"
                            : widget.food.fields.category == "Snack"
                                ? "assets/images/category_icon/snack_icon.png"
                                : "assets/images/category_icon/other_icon.png"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromRGBO(219, 255, 183, 1),
                  ),
                  child: Text(
                    widget.food.fields.category,
                    style: TextStyle(color: Colors.green[800], fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15),
                  child: Text(
                    Casing.titleCase(widget.food.fields.product),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    Casing.titleCase(widget.food.fields.merchantArea),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15),
                  child: Text(
                    widget.food.fields.merchantName,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15),
                  child: Text(
                    widget.food.fields.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8, top: 10),
                    child: ElevatedButton.icon(
                      onPressed: widget.isFavorited == true ? null : () {
                        addToFavorite(context, widget.food.pk);
                      },
                      icon: const Icon(Icons.favorite),
                      label: Text((widget.isFavorited == true ? "Already in favorite" : "Add to favorite")),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          foregroundColor: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            const Positioned(
              top: 15,
              left: 15,
              child: BackBtn(),
            ),
            Positioned(
              top: 15,
              right: 15,
              child: FavStatus(isFavorited: widget.isFavorited, heightSize: 50, widthSize: 50,),
            )
          ]),
        ),
      ),
    );
  }
}

Future<void> addToFavorite(BuildContext context, int foodId) async {
  var userId = UserInfo.data["id"];
  var url = Uri.parse(
      'http://10.0.2.2:8000/api/foods/add_to_fav_flutter/$foodId/$userId/');

  var requestBody = {"user_id": userId};
  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(requestBody),
  );

  if (context.mounted) {
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Food added successfully to favorite!')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to add drink')));
    }
  }
}
