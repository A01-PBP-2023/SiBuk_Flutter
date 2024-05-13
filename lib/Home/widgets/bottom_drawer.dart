import 'package:flutter/material.dart';

class BottomDrawer extends StatefulWidget {
  const BottomDrawer(
      {super.key, required this.currentScreen, this.onChangeScreen});
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
          icon: Icon(Icons.breakfast_dining),
          label: "Foods",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_drink),
          label: "Drinks",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: "Favorites",
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
