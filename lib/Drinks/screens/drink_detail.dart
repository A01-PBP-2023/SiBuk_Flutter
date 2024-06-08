import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sibuk_mobile/Drinks/models/drink.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dart_casing/dart_casing.dart';
import 'package:sibuk_mobile/Base/back_btn.dart';
import 'package:sibuk_mobile/Base/fav_status.dart';
import 'package:sibuk_mobile/main.dart';


class DrinkDetail extends StatefulWidget {
  const DrinkDetail({super.key, required this.drink, required this.isFavorited});
  final Drink drink;
  final bool isFavorited;

  @override
  State<DrinkDetail> createState() => _DrinkDetailState();
}

class _DrinkDetailState extends State<DrinkDetail> {


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
                    (widget.drink.fields.category == "Kopi"
                        ? "assets/images/category_icon/coffee_icon.png"
                                : "assets/images/category_icon/non_coffee_icon.png"),
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
                    widget.drink.fields.category,
                    style: TextStyle(color: Colors.green[800], fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15),
                  child: Text(
                    Casing.titleCase(widget.drink.fields.product),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    Casing.titleCase(widget.drink.fields.merchantArea),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15),
                  child: Text(
                    widget.drink.fields.merchantName,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15),
                  child: Text(
                    widget.drink.fields.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8, top: 10),
                    child: ElevatedButton.icon(
                      onPressed: widget.isFavorited == true ? null : () {
                        addToFavorite(context, widget.drink.pk);
                      },
                      icon: const Icon(Icons.favorite),
                      label: Text((widget.isFavorited == true ? "Already in favorite" : "Add to favorite")),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, foregroundColor: Colors.white),
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
  var url = Uri.parse('http://10.0.2.2:8000/api/drinks/add_to_fav_flutter/$foodId/$userId/');

  var requestBody = {"user_id": userId};
  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(requestBody),
  );

  if (context.mounted) {
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Drink added successfully to favorite!')));
      Navigator.pop(context);

    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to add food')));
    }
  }
}


