import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sibuk_mobile/Favorite/widgets/favfood_list.dart';
import 'package:sibuk_mobile/Favorite/widgets/favdrink_list.dart';

class FavoriteMain extends StatefulWidget {
  const FavoriteMain({super.key});

  @override
  State<FavoriteMain> createState() => _FavoriteMainState();
}

class _FavoriteMainState extends State<FavoriteMain> {
  String? onActive;

  @override
  void initState() {
    onActive = "food";
    super.initState();
  }

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
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: Text(
                  "Explore Favorites",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30, left: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          onActive = "food";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: onActive == "food" ? const Color.fromRGBO(33, 45, 28, 1) : const Color.fromRGBO(243, 244, 246, 1),
                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          "Food",
                          style: TextStyle(
                            color:  onActive == "food" ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell( 
                      onTap: () {
                        setState(() {
                          onActive = "drink";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: onActive == "drink" ? const Color.fromRGBO(33, 45, 28, 1) : const Color.fromRGBO(243, 244, 246, 1),
                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          "Drink",
                          style: TextStyle(
                            color: onActive == "drink" ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: onActive == "food" ? const FavFood() : const FavDrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
