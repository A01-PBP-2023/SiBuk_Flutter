import 'package:flutter/material.dart';
import 'package:sibuk_mobile/screens/home.dart';
import 'package:sibuk_mobile/widgets/bottom_drawer.dart';

class SibukPage extends StatefulWidget {
  const SibukPage({super.key, this.name});
  final String? name;

  @override
  State<SibukPage> createState() => _SibukPageState();
}

class _SibukPageState extends State<SibukPage> {
  var screenNow = 0;
  changeScreen(int screen) {
    setState(() {
      screenNow = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(
        name: widget.name,
        onChangeScreen: changeScreen,
      ),
      bottomNavigationBar: BottomDrawer(
        currentScreen: screenNow,
        onChangeScreen: changeScreen,
      ),
    );
  }
}
// Bottom Drawer Class
