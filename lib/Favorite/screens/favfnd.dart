import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sibuk_mobile/models/food.dart';
import 'package:dart_casing/dart_casing.dart';
import 'dart:convert';

class FavFoodList extends StatefulWidget {
  const FavFoodList({super.key});

  @override
  State<FavFoodList> createState() => _FavFoodListState();
}

class _FavFoodListState extends State<FavFoodList> {
  Future<List<Food>> fetchFood() async {
    var url = Uri.parse('http://10.0.2.2:8000/favorites/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Food
    List<Food> listFood = [];


    for (var i = 0; i < 5; i++) {
      if (data != null) {
        listFood.add(Food.fromJson(data[i]));
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
              return SizedBox(
                width: double.infinity,
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/f-grid-icon.png",
                          width: 200,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          Casing.titleCase(
                              "${snapshot.data![index].fields.product}"),
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          Casing.titleCase(
                              "${snapshot.data![index].fields.merchantArea}"),
                        ),
                        Text(Casing.titleCase(
                           "${snapshot.data![index].fields.merchantName}")
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
