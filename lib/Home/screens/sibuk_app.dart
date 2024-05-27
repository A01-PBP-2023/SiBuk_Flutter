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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0, 134, 47, 1),
        ),
        child: screenNow == 2 ? HomePage(onChangeScreen: changeScreen, name: widget.name,) : screenNow == 0 ? const FoodList() : const Text("This is Screen"),
      ),
      bottomNavigationBar: BottomDrawer(
        currentScreen: screenNow,
        onChangeScreen: changeScreen,
      ),
    );
  }
}
// Bottom Drawer Class
