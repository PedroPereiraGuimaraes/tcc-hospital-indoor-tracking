// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:front_end/views/widgets/Navbar.dart';

class SettignsScreen extends StatefulWidget {
  const SettignsScreen({Key? key}) : super(key: key);

  @override
  State<SettignsScreen> createState() => _SettignsScreenState();
}

class _SettignsScreenState extends State<SettignsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isAdmin: true,
        hasBackButton: true,
      ),
      body: Center(
        child: Text('Settings Screen'),
      ),
      bottomNavigationBar: NavBar(currentIndex: 3),
    );
  }
}
