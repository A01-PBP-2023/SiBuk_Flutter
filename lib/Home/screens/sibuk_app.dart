import 'package:flutter/material.dart';
import 'package:sibuk_mobile/Home/screens/home.dart';
import 'package:sibuk_mobile/Home/widgets/bottom_drawer.dart';
import 'package:sibuk_mobile/Foods/screens/food_main.dart';
import 'package:sibuk_mobile/Drinks/screens/drink_main.dart';
import 'package:sibuk_mobile/Favorite/screens/favorite_main.dart';

class SibukPage extends StatefulWidget {
  const SibukPage({super.key, this.name});
  final String? name;

  @override
  State<SibukPage> createState() => _SibukPageState();
}

class _SibukPageState extends State<SibukPage> {
  var screenNow = 2;
  changeScreen(int screen) {
    setState(() {
      screenNow = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            Offstage(
              offstage: screenNow != 0,
              child: TickerMode(enabled: screenNow == 0, child: const MaterialApp(home: FoodMain())),
            ),
            Offstage(
              offstage: screenNow != 1,
              child: TickerMode(enabled: screenNow == 1, child: const MaterialApp(home: DrinkMain())),
            ),
            Offstage(
              offstage: screenNow != 2,
              child: TickerMode(enabled: screenNow == 2, child: HomePage(onChangeScreen: changeScreen, name: widget.name,)),
            ),
            Offstage(
              offstage: screenNow != 3,
              child: TickerMode(enabled: screenNow == 3, child: const MaterialApp(home: FavoriteMain())),
            ),
            // Offstage(
            //   offstage: screenNow != 3,
            //   child: TickerMode(enabled: screenNow == 3, child: const MaterialApp(home: FavoriteMain())),
            // ),
        ],
      ),
      bottomNavigationBar: BottomDrawer(
        currentScreen: screenNow,
        onChangeScreen: changeScreen,
      ),
    );
  }
}
// Bottom Drawer Class
