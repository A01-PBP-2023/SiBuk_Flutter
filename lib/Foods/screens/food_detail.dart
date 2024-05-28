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
                              (snapshot.data[0].fields.category == "Nasi"
                                  ? "assets/images/category_icon/rice_icon.png"
                                  : snapshot.data[0].fields.category == "Mie"
                                      ? "assets/images/category_icon/noodle_icon.png"
                                      : snapshot.data[0].fields.category ==
                                              "Snack"
                                          ? "assets/images/category_icon/snack_icon.png"
                                          : "assets/images/category_icon/other_icon.png"),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 20),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color.fromRGBO(219, 255, 183, 1),
                            ),
                            child: Text(
                              snapshot.data[0].fields.category,
                              style: TextStyle(
                                  color: Colors.green[800], fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Text(
                              Casing.titleCase(snapshot.data[0].fields.product),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              Casing.titleCase(
                                  snapshot.data[0].fields.merchantArea),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 15),
                            child: Text(
                              snapshot.data[0].fields.merchantName,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 15),
                            child: Text(
                              snapshot.data[0].fields.description,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),

                        ],
                      ),
                      Positioned(
                        top: 15,
                        left: 15,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const BackButton(),
                        ),
                      ),
                    ]),
                  ),
                ),
              );
            }
          }
        });
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: Colors.white,
      ),
      width: 50,
      height: 50,
      child: const Icon(Icons.arrow_back),
    );
  }
}
