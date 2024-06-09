import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sibuk_mobile/Foods/models/food.dart';
import 'package:dart_casing/dart_casing.dart';
import 'dart:convert';
import 'package:sibuk_mobile/main.dart';


class FavFood extends StatefulWidget {
  const FavFood({super.key});

  @override
  State<FavFood> createState() => _FavFoodState();
}

class _FavFoodState extends State<FavFood> {
  late List<Food> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = [];
    fetchFavoritesFood();
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
        itemCount: _favorites.length,
        itemBuilder: (BuildContext context, int index) {
          Food food = _favorites[index];
          return InkWell(
            onTap: () {
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
              ]),
            ),
          );
        });
  }
}
