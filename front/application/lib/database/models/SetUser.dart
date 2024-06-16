import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String _name = '';
  String _email = '';
  String _register = '';
  bool _isAdmin = false;

  String get name => _name;
  String get email => _email;
  String get register => _register;
  bool get isAdmin => _isAdmin;

  void setUser(String name, String email, String register, bool isAdmin) {
    _name = name;
    _email = email;
    _register = register;
    _isAdmin = isAdmin;
    notifyListeners();
  }
}
