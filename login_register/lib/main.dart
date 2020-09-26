import 'package:flutter/material.dart';
import 'package:login_register/screens/dasboard_view.dart';
import 'package:login_register/screens/login_view.dart';
import 'package:login_register/screens/register_view.dart';
import 'package:login_register/screens/splashscreen_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Login Register Page",
    initialRoute: "/",
    routes: {
      "/": (context) => LauncherPage(),
      LoginPage.routeName: (context) => LoginPage(),
      RegisterPage.routeName: (context) => RegisterPage(),
      Dashboard.routeName: (context) => Dashboard()
    },
  ));
}
