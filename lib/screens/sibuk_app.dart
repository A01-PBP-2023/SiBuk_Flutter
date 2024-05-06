import 'package:flutter/material.dart';
import 'package:sibuk_mobile/screens/home.dart';

class SibukPage extends StatefulWidget {
  const SibukPage({super.key, this.name});
  final String? name;

  @override
  State<SibukPage> createState() => _SibukPageState();
}

class _SibukPageState extends State<SibukPage> {
  var screenNow = 0;
  changeScreen (int screen) {
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
class BottomDrawer extends StatefulWidget {
  const BottomDrawer({super.key, required this.currentScreen, this.onChangeScreen});
  final int currentScreen;
  final Function? onChangeScreen;

  @override
  State<BottomDrawer> createState() => _BottomDrawerState();
}

class _BottomDrawerState extends State<BottomDrawer> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      showUnselectedLabels: false,
      unselectedIconTheme: const IconThemeData(
        color: Color.fromRGBO(1, 77, 47, 0.84),
      ),
      type: BottomNavigationBarType.fixed,
      selectedIconTheme:
          const IconThemeData(color: Color.fromRGBO(1, 77, 47, 1)),
      selectedItemColor: const Color.fromRGBO(1, 77, 47, 1),
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.breakfast_dining),
          label: "Foods",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_drink),
          label: "Drinks",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: "Reviews",
        ),
      ],
      currentIndex: widget.currentScreen,
      onTap: (int index) => {widget.onChangeScreen!(index)},
    );
  }
}
