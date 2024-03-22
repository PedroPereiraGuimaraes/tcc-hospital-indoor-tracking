// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:front_end/views/screens/LoginScreen.dart';
import 'package:front_end/views/screens/SplashScreen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Coffe Application",
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        //'/register': (context) => RegisterPage(),
        //'/admin': (context) => AdminPage(),
        //'/stocks': (context) => StockPage(),
        //'/stocksadmin': (context) => StockPageAdmin(),
      },
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF0081DF, {
          50: Color(0xFFE0F2F8),
          100: Color(0xFFB3E0F2),
          200: Color(0xFF80C9EA),
          300: Color(0xFF4DA3D9),
          400: Color(0xFF2691D1),
          500: Color(0xFF0081DF),
          600: Color(0xFF0075D9),
          700: Color(0xFF0069D3),
          800: Color(0xFF005DCD),
          900: Color(0xFF0048C3),
        }),
      ),
    );
  }
}
