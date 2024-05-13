import 'package:flutter/material.dart';
import 'package:sibuk_mobile/Home/screens/home.dart';
import 'package:sibuk_mobile/Home/widgets/bottom_drawer.dart';
import 'package:sibuk_mobile/Foods/screens/food.dart';

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
      body: screenNow == 0 ? HomePage(
        name: widget.name,
        onChangeScreen: changeScreen,
      ) : screenNow == 1 ? const FoodList() : const Text("No Screen added yet"),
      bottomNavigationBar: BottomDrawer(
        currentScreen: screenNow,
        onChangeScreen: changeScreen,
      ),
    );
  }
}
// Bottom Drawer Class
