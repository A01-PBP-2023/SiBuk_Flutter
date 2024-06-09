import 'package:flutter/material.dart';

class FavStatus extends StatelessWidget {
  const FavStatus({super.key, required this.isFavorited, required this.widthSize, required this.heightSize});

  final bool isFavorited;
  final double widthSize;
  final double heightSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: Colors.white,
      ),
      width: widthSize,
      height: heightSize,
      child: Icon(Icons.favorite, color: isFavorited == true ? Colors.red : Colors.grey,),
    );
  }
}
