// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_end/views/screens/InsertNewEquipament.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isAdmin;
  final bool hasBackButton;
  const CustomAppBar(
      {Key? key, required this.isAdmin, required this.hasBackButton})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 0, 129, 223),
      leading: widget.hasBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              iconSize: 20,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      actions: widget.isAdmin
          ? [
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                iconSize: 28,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEquipamentList(),
                    ),
                  );
                },
              ),
            ]
          : null,
    );
  }
}
