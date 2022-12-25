import 'package:blood_pressure/common/widgets/bottom_bar.dart';
import 'package:blood_pressure/features/account/screens/account_screen.dart';
import 'package:blood_pressure/features/auth/screens/auth_screen.dart';
import 'package:blood_pressure/features/home/screens/home_screens.dart';
import 'package:blood_pressure/features/home/widgets/blood_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case BloodPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BloodPage(),
      );
    case AccountSrceen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AccountSrceen(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
