import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sibuk_mobile/Foods/screens/food_detail.dart';
import 'package:sibuk_mobile/Foods/models/food.dart';
import 'package:dart_casing/dart_casing.dart';
import 'dart:convert';
import 'package:sibuk_mobile/main.dart';
import 'package:sibuk_mobile/Base/fav_status.dart';


class FoodList extends StatefulWidget {
  const FoodList({super.key});

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  late List<Food> _allFoods;
  late List<Food> _favorites;

  @override
  void initState() {
    super.initState();
    _allFoods = [];
    _favorites = [];
    fetchFood();
    fetchFavoritesFood();
  }



  Future<void> fetchFood() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/foods/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      _allFoods = body.map((dynamic item) => Food.fromJson(item)).toList();
      setState(() {});
    } else {
      throw Exception('Failed to load foods');
    }
  }

  Future<void> fetchFavoritesFood() async {
    var userId = UserInfo.data["id"];
    var url = Uri.parse('http://10.0.2.2:8000/favorites/get-favfood/$userId/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      _favorites = body.map((dynamic item) => Food.fromJson(item)).toList();
      setState(() {});
    } else {
      throw Exception('Failed to load foods');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        shrinkWrap: true,
        primary: false,
        itemCount: _allFoods.length,
        itemBuilder: (BuildContext context, int index) {
          Food food = _allFoods[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetail(
                      food: food,
                      isFavorited: _favorites
                          .map((item) => item.fields.product)
                          .contains(food.fields.product),
                    ),
                  )).then((value) => setState(() {
                    fetchFavoritesFood();
                  }));
            },
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(245, 255, 235, 1)),
              child: Stack(children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (food.fields.category == "Nasi"
                        ? Image.asset(
                            "assets/images/category_icon_no_bg/rice.png",
                            width: 120,
                          )
                        : food.fields.category == "Mie"
                            ? Image.asset(
                                "assets/images/category_icon_no_bg/noodle.png",
                                width: 120,
                              )
                            : food.fields.category == "Snack"
                                ? Image.asset(
                                    "assets/images/category_icon_no_bg/snack.png",
                                    width: 120,
                                  )
                                : Image.asset(
                                    "assets/images/category_icon_no_bg/other.png",
                                    width: 120,
                                  )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: Casing.titleCase(food.fields.product),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[600]),
                            ),
                          ),
                        ),
                        Text(
                          Casing.titleCase(food.fields.merchantArea),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: FavStatus(
                      isFavorited: _favorites
                          .map((item) => item.fields.product)
                          .contains(food.fields.product),
                      widthSize: 10,
                      heightSize: 10),
                )
              ]),
            ),
          );
        });
  }
}
