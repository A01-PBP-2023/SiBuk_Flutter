import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sibuk_mobile/Foods/screens/food_detail.dart';
import 'package:sibuk_mobile/Foods/models/food.dart';
import 'package:dart_casing/dart_casing.dart';
import 'dart:convert';

class FoodList extends StatefulWidget {
  const FoodList({super.key});

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  Future<List<Food>> fetchFood() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse('http://10.0.2.2:8000/api/foods/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Food
    List<Food> listFood = [];
    for (var d in data) {
      if (d != null) {
        listFood.add(Food.fromJson(d));
      }
    }
    return listFood;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchFood(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Tidak ada data Makanan.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                shrinkWrap: true,
                primary: false,
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodDetail(
                            food: snapshot.data![index],
                          ),
                        ));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(245, 255, 235, 1)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (snapshot.data![index].fields.category == "Nasi"
                            ? Image.asset(
                                "assets/images/category_icon_no_bg/rice.png",
                                width: 120,
                              )
                            : snapshot.data![index].fields.category == "Mie"
                                ? Image.asset(
                                    "assets/images/category_icon_no_bg/noodle.png",
                                    width: 120,
                                  )
                                : snapshot.data![index].fields.category ==
                                        "Snack"
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
                                  text: Casing.titleCase(
                                      "${snapshot.data![index].fields.product}"),
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[600]),
                                ),
                              ),
                            ),
                            Text(
                              Casing.titleCase(
                                  snapshot.data![index].fields.merchantArea),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        });
  }
}
