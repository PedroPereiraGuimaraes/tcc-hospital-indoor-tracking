// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:front_end/database/models/SetUser.dart';
import 'package:front_end/views/screens/AdminScreen.dart';
import 'package:front_end/views/screens/EquipmentListScreen.dart';
import 'package:front_end/views/screens/HistoricScreen.dart';
import 'package:front_end/views/screens/LoginScreen.dart';
import 'package:front_end/views/screens/ProfileScreen.dart';
import 'package:front_end/views/screens/RoomsScreen.dart';
import 'package:front_end/views/screens/SplashScreen.dart';
import 'package:front_end/views/screens/RegisterScreen.dart';
import 'package:provider/provider.dart';




void main() async {
  runApp(ChangeNotifierProvider(create: (context) => SUser(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
     
    super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hospital Indoor Tracking System",
      initialRoute: '/login',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/rooms': (context) => RoomsScreen(),
        '/equipments': (context) => EquipmentListScreen(),
        '/admin': (context) => AdminScreen(),
        '/profile': (context) => ProfileScreen(),
        '/historic': (context) => HistoricScreen(),
      },
      theme: ThemeData(primaryColor: Colors.blue, primarySwatch: Colors.blue),
    );
  }
}
