import 'package:flutter/material.dart';
import 'package:sibuk_mobile/models/food.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dart_casing/dart_casing.dart';





class FoodDetail extends StatefulWidget {
  const FoodDetail({super.key, required this.pk});
  final int? pk;

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  Future<List<Food>> fetchFood() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse('http://10.0.2.2:8000/api/foods/get_food/${widget.pk}');
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
              return SizedBox(
                width: double.infinity,
                height: 290,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(245, 255, 235, 1)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (snapshot.data![index].fields.category == "Nasi"
                            ? Image.asset(
                                "assets/images/category_icon_no_bg/rice.png",
                                width: 200,
                              )
                            : snapshot.data![index].fields.category == "Mie"
                                ? Image.asset(
                                    "assets/images/category_icon_no_bg/noodle.png",
                                    width: 200,
                                  )
                                : snapshot.data![index].fields.category ==
                                        "Snack"
                                    ? Image.asset(
                                        "assets/images/category_icon_no_bg/snack.png",
                                        width: 200,
                                      )
                                    : Image.asset(
                                        "assets/images/category_icon_no_bg/other.png",
                                        width: 200,
                                      )),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Column(
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                Casing.titleCase(
                                    "${snapshot.data![index].fields.merchantName}"),
                                style: const TextStyle(
                                  fontSize: 13
                                ),
                              ),
                            ],
                          ),
                        ),
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