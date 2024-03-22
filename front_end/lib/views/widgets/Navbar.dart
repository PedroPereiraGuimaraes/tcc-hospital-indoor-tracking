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
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? Colors.blue : Colors.white,
            ),
            onPressed: () {
              _navigateToPage(0);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: _currentIndex == 1 ? Colors.blue : Colors.white,
            ),
            onPressed: () {
              _navigateToPage(0);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: _currentIndex == 2 ? Colors.blue : Colors.white,
            ),
            onPressed: () {
              _navigateToPage(0);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 3 ? Colors.blue : Colors.white,
            ),
            onPressed: () {
              _navigateToPage(0);
            },
          ),
        ],
      ),
    );
  }
}
