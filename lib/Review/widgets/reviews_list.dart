import 'package:dart_casing/dart_casing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


import 'package:sibuk_mobile/main.dart';
import 'package:sibuk_mobile/Review/models/reviews.dart';
import 'package:sibuk_mobile/Foods/models/food.dart';
import 'package:sibuk_mobile/Foods/screens/food_detail.dart';
import 'package:sibuk_mobile/Drinks/models/drink.dart';
import 'package:sibuk_mobile/Drinks/screens/drink_detail.dart';

class ReviewList extends StatefulWidget {
  const ReviewList({super.key});

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  late List<Review> _reviews;
  late List<Drink> _favoritesDrink;
  late List<Food> _favoritesFood;
  String _selectedSortOption = 'rating';

  @override
  void initState() {
    super.initState();
    _reviews = [];
    _favoritesDrink = [];
    _favoritesFood = [];
    fetchFavoritesFood();
    fetchFavoriteDrink();
    fetchReviews(_selectedSortOption);
  }

  Future<void> fetchReviews(String sortOption) async {
    var url = Uri.parse('http://10.0.2.2:8000/reviews/get_all_reviews_json?sort_by=$sortOption'); // Update with your API endpoint
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      _reviews = body.map((dynamic item) => Review.fromJson(item)).toList();
      setState(() {});
    } else {
      throw Exception('Failed to load reviews');
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
      _favoritesDrink = body.map((dynamic item) => Drink.fromJson(item)).toList();
      setState(() {});
    } else {
      throw Exception('Failed to load drinks');
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
      _favoritesFood = body.map((dynamic item) => Food.fromJson(item)).toList();
      setState(() {});
    } else {
      throw Exception('Failed to load foods');
    }
  }

  Future<Drink?> fetchDrink(int id) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/drinks/get_drink/$id');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      dynamic body = json.decode(response.body);
      var drink = Drink.fromJson(body[0]);
      return drink;
    } else {
      throw Exception('Failed to load drinks');
    }
  }

  Future<Food?> fetchFood(int id) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/foods/get_food/$id');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      dynamic body = json.decode(response.body);
      var food = Food.fromJson(body[0]);
      return food;
    } else {
      throw Exception('Failed to load foods');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
        value: _selectedSortOption,
        onChanged: (String? newValue) {
          setState(() {
            _selectedSortOption = newValue!;
            fetchReviews(_selectedSortOption);
          });
        },
        items: <String>['reviews', 'rating']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text('Sort by ${value == 'reviews' ? 'Number of Reviews' : 'Rating'}'),
          );
        }).toList(),
      ),
      GridView.builder(
        padding: const EdgeInsets.all(4),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        shrinkWrap: true,
        primary: false,
        itemCount: _reviews.length,
        itemBuilder: (BuildContext context, int index) {
          Review review = _reviews[index];
          double rating = review.fields.averageRating;
          int numReviews = review.fields.numReviews;
          return FutureBuilder(
            future: review.model == "foods.food" ? fetchFood(review.pk) : fetchDrink(review.pk),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }else {
                var item = snapshot.data;
                return InkWell(
                  onTap: () {
                    if (review.model == "foods.food" && item is Food) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodDetail(
                            food: item,
                            isFavorited: _favoritesFood
                                .map((item) => item.fields.product)
                                .contains(item.fields.product),
                          ),
                        ),
                      ).then((value) => setState(() {
                        fetchFavoritesFood();
                      }));
                    } else if (review.model == "drinks.drink" && item is Drink) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DrinkDetail(
                            drink: item,
                            isFavorited: _favoritesDrink
                                .map((item) => item.fields.product)
                                .contains(item.fields.product),
                          ),
                        ),
                      ).then((value) => setState(() {
                        fetchFavoriteDrink();
                      }));
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(color: Color.fromRGBO(245, 255, 235, 1)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingBarIndicator(
                              rating: rating,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                          ]
                        ),
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                Casing.titleCase("$numReviews reviews"),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ]
                        ),
                        if (item is Food) ...[
                          (item.fields.category == "Nasi"
                              ? Image.asset(
                            "assets/images/category_icon_no_bg/rice.png",
                            width: 120,
                          )
                              : item.fields.category == "Mie"
                              ? Image.asset(
                            "assets/images/category_icon_no_bg/noodle.png",
                            width: 120,
                          )
                              : item.fields.category == "Snack"
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
                                    text: Casing.titleCase(item.fields.product),
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[600]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ] else if (item is Drink) ...[
                          (item.fields.category == "Kopi"
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
                                    text: Casing.titleCase(item.fields.product),
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[600]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]
                      ],
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
      ],
    );
  }
}
