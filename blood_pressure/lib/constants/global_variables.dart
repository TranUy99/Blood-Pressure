import 'package:flutter/material.dart';

String uri = 'http://172.20.10.4:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromARGB(255, 98, 176, 227);
  static const backgroundColor = Color.fromARGB(255, 155, 219, 247);
  static const orangeAccent = Color.fromARGB(255, 221, 105, 85);
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
}
