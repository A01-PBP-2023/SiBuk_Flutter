import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sibuk_mobile/Drinks/screens/drink_detail.dart';
import 'package:sibuk_mobile/Drinks/models/drink.dart';
import 'package:dart_casing/dart_casing.dart';
import 'dart:convert';
import 'package:sibuk_mobile/main.dart';
import 'package:sibuk_mobile/Base/fav_status.dart';


class DrinkList extends StatefulWidget {
  const DrinkList({super.key});

  @override
  State<DrinkList> createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList> {
  late List<Drink> _allDrinks;
  late List<Drink> _favorites;

  @override
  void initState() {
    super.initState();
    _allDrinks = [];
    _favorites = [];
    fetchDrink();
    fetchFavoriteDrink();
  }

 Future<void> fetchDrink() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/drinks/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      _allDrinks = body.map((dynamic item) => Drink.fromJson(item)).toList();
      setState(() {});
    } else {
      throw Exception('Failed to load drinks');
    }
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
      itemCount: _allDrinks.length,
      itemBuilder: (BuildContext context, int index) {
        Drink drink = _allDrinks[index];
        return InkWell(
          onTap: () {
           Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DrinkDetail(
                      drink: drink,
                      isFavorited: _favorites
                          .map((item) => item.fields.product)
                          .contains(drink.fields.product),
                    ),
                  )).then((value) => setState(() {
                    fetchFavoriteDrink();
                  }));
          },
          child: Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(245, 255, 235, 1)),
            child: Stack(
              children: [Column(
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
                            text: Casing.titleCase(
                                drink.fields.product),
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[600]),
                          ),
                        ),
                      ),
                      Text(
                        Casing.titleCase(
                            drink.fields.merchantArea),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              FavStatus(
                   isFavorited: _favorites
                       .map((item) => item.fields.product)
                       .contains(drink.fields.product),
                   widthSize: 10,
                   heightSize: 10)
            ]),
          ),
        );
      },
    );
  }
}
