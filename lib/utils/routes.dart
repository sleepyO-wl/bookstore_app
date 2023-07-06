import 'package:bookstore/screens/auth_screen.dart';
import 'package:bookstore/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.arguments) {
    case AuthenticationScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => const AuthenticationScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (ctx) => const HomeScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (ctx) => const Scaffold(
          body: Center(
            child: Text('Error 404!'),
          ),
        ),
      );
  }
}
