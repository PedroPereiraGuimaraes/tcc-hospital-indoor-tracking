// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:front_end/views/screens/InsertNewEquipment.dart';
import 'package:front_end/views/screens/InsertNewRoom.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isAdmin;
  final bool isRoom;
  final bool hasBackButton;
  const CustomAppBar(
      {Key? key, required this.isRoom, required this.isAdmin, required this.hasBackButton})
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
              iconSize: 15,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      title: Row(
        children: [
          Icon(
            Icons.device_hub,
            color: Colors.white,
            size: 25,
          ),
          SizedBox(width: 10),
          Text(
            "Localizador de dispositivos",
            style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.josefinSans().fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: widget.isAdmin
          ? [
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                iconSize: 23,
                onPressed: () {
                  if (widget.isRoom) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddRoomList(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEquipamentList(),
                      ),
                    );
                  }
                },
              ),
            ]
          : null,
    );
  }
}
