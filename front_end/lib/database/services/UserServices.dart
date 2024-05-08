import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> authenticate(String register, String password) async {
  final url = Uri.parse('http://10.0.2.2:8000/user/login');
  final headers = {
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    "register": register,
    "password": password,
  });

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return 'Success';
    } else {
      final errorMessage =
          jsonDecode(response.body)['message'] ?? 'Unknown error';
      throw Exception('Failed to authenticate: $errorMessage');
    }
  } catch (e) {
    throw Exception('An error occurred while authenticating: ${e.toString()}');
  }
}
