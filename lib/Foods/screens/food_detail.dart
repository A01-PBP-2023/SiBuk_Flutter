import 'package:flutter/material.dart';
import 'package:sibuk_mobile/Foods/models/food.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dart_casing/dart_casing.dart';
import 'package:sibuk_mobile/Foods/widgets/back_btn.dart';

class FoodDetail extends StatelessWidget {
  const FoodDetail({super.key, required this.food});
  final Food food;
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
                    (food.fields.category == "Nasi"
                        ? "assets/images/category_icon/rice_icon.png"
                        : food.fields.category == "Mie"
                            ? "assets/images/category_icon/noodle_icon.png"
                            : food.fields.category == "Snack"
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
                    food.fields.category,
                    style: TextStyle(color: Colors.green[800], fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15),
                  child: Text(
                    Casing.titleCase(food.fields.product),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    Casing.titleCase(food.fields.merchantArea),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15),
                  child: Text(
                    food.fields.merchantName,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15),
                  child: Text(
                    food.fields.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const Positioned(
              top: 15,
              left: 15,
              child: BackBtn(),
            ),
          ]),
        ),
      ),
    );
  }
}
