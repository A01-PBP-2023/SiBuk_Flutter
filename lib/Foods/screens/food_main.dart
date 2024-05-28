import 'package:flutter/material.dart';
import 'package:sibuk_mobile/Foods/widgets/food_list.dart';

class FoodMain extends StatelessWidget {
  const FoodMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: const EdgeInsets.all(10),
       decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("This is search box"),
            FoodList()
          ],
        ),
      ),
    );
  }
}
