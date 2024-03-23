// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:front_end/views/screens/LoginScreen.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;

  NavBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          CustomPageRoute(builder: (context) => LoginScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          CustomPageRoute(builder: (context) => LoginScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          CustomPageRoute(builder: (context) => LoginScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          CustomPageRoute(builder: (context) => LoginScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.blue, Colors.white, Colors.white],
          stops: [0.1, 0.1, 0.1, 1.0],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconButton('assets/homeIcon.png', 0),
          _buildIconButton('assets/searchIcon.png', 1),
          _buildIconButton('assets/listIcon.png', 2),
          _buildIconButton('assets/settingsIcon.png', 3),
        ],
      ),
    );
  }

  Widget _buildIconButton(String image, int index) {
    return GestureDetector(
      onTap: () {
        _navigateToPage(index);
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: _currentIndex == index
              ? const Color.fromARGB(255, 0, 73, 126)
              : const Color.fromARGB(255, 0, 129, 223),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Image.asset(
          image,
          width: 10,
          height: 10,
        ),
      ),
    );
  }
}
