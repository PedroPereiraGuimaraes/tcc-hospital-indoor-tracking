import 'dart:convert';
import 'package:front_end/database/services/models/User.dart';
import 'package:http/http.dart' as http;

// fazer login na API

Future<String> authenticate(String register, String password) async {
  print('register: $register');
  final url = Uri.parse('http://10.0.2.2:8000/user/login');
  final response = await http.post(
    url,
    body:
        {"register": "pedro", "password": "123456"},
   
  );
  print('Response status: ${response}');
  if (response.statusCode == 200) {
    return 'Success';
  } else {
    throw Exception('Failed to authenticate');
  }
}
