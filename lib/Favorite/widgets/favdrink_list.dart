import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sibuk_mobile/Drinks/models/drink.dart';
import 'package:dart_casing/dart_casing.dart';
import 'dart:convert';
import 'package:sibuk_mobile/main.dart';


class FavDrink extends StatefulWidget {
  const FavDrink({super.key});

  @override
  State<FavDrink> createState() => _FavDrinkState();
}

class _FavDrinkState extends State<FavDrink> {
  late List<Drink> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = [];
    fetchFavoriteDrink();
  }



  Future<void> fetchFavoriteDrink() async {
    var userId = UserInfo.data["id"];
    var url = Uri.parse('http://10.0.2.2:8000/favorites/get-favdrink/$userId/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      _favorites = body.map((dynamic item) => Drink.fromJson(item)).toList();
      setState(() {});
    } else {
      throw Exception('Failed to load drinks');
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
          Drink drink = _favorites[index];
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
                    (drink.fields.category == "Kopi"
                      ? Image.asset(
                          "assets/images/category_icon_no_bg/coffee.png",
                          width: 120,
                        )
                      : Image.asset(
                          "assets/images/category_icon_no_bg/non_coffee.png",
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
                              text: Casing.titleCase(drink.fields.product),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[600]),
                            ),
                          ),
                        ),
                        Text(
                          Casing.titleCase(drink.fields.merchantArea),
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
