import 'package:flutter/material.dart';
import 'package:sibuk_mobile/Home/screens/home.dart';
import 'package:sibuk_mobile/Home/widgets/bottom_drawer.dart';
import 'package:sibuk_mobile/Foods/screens/food_main.dart';

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
              offstage: screenNow != 2,
              child: TickerMode(enabled: screenNow == 2, child: MaterialApp(home: HomePage(onChangeScreen: changeScreen, name: widget.name,))),
            ),
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
