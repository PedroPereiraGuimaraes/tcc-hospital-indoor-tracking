// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_end/views/widgets/Appbar.dart';
import 'package:front_end/views/widgets/Navbar.dart';

class EquipmentListScreen extends StatefulWidget {
  const EquipmentListScreen({super.key});

  @override
  State<EquipmentListScreen> createState() => _EquipmentListScreenState();
}

class _EquipmentListScreenState extends State<EquipmentListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isAdmin: true,
        hasBackButton: true,
      ),
      body: Center(
        child: Text('Equipments List Screen'),
      ),
      bottomNavigationBar: NavBar(currentIndex: 1),
    );
  }
}
