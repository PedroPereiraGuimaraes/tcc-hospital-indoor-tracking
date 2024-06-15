import 'dart:convert';

import 'package:http/http.dart' as http;

const String URL = 'http://localhost:8000';
//const String URL = 'http://10.0.2.2:8000';

Future<String> authenticate(String email, String password) async {
  final url = Uri.parse('$URL/user/login');
  final headers = {
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    "email": email,
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

Future<String> registerUser(
    String name, String register, String password, String email) async {
  final url = Uri.parse('http://localhost:8000/user/create');
  final headers = {
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    "name": name,
    "register": register,
    "password": password,
    "email": email,
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
      throw Exception('Failed to register user: $errorMessage');
    }
  } catch (e) {
    throw Exception('An error occurred while registering user: ${e.toString()}');
  }
}

Future<List> getAllUsers() async {
  final url = Uri.parse('http://localhost:8000/user/read-all');
  final headers = {
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final errorMessage =
          jsonDecode(response.body)['message'] ?? 'Unknown error';
      throw Exception('Failed to get all users: $errorMessage');
    }
  } catch (e) {
    throw Exception('An error occurred while getting all users: ${e.toString()}');
  }
}

Future<String> changeUserAdmin(String register, bool isAdmin) async {
  final url = Uri.parse('http://localhost:8000/user/change-user-admin');
  final headers = {
    'Content-Type': 'application/json',
  };
  print(register);
  final body = jsonEncode({
    "register": register,
    "is_admin": isAdmin,
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
      throw Exception('Failed to change user admin: $errorMessage');
    }
  } catch (e) {
    throw Exception('An error occurred while changing user admin: ${e.toString()}');
  }
}

Future<String> deleteUser(String register) async {
  final url = Uri.parse('http://localhost:8000/user/delete');
  final headers = {
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    "register": register,
  });

  try {
    final response = await http.delete(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return 'Success';
    } else {
      final errorMessage =
          jsonDecode(response.body)['message'] ?? 'Unknown error';
      throw Exception('Failed to delete user: $errorMessage');
    }
  } catch (e) {
    throw Exception('An error occurred while deleting user: ${e.toString()}');
  }
}

// atualizar usuário
Future<String> updateUser(
    String name, String register, String password, String email) async {
  final url = Uri.parse('http://localhost:8000/user/update');
  final headers = {
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    "name": name,
    "register": register,
    "password": password,
    "email": email,
  });

  try {
    final response = await http.put(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return 'Success';
    } else {
      final errorMessage =
          jsonDecode(response.body)['message'] ?? 'Unknown error';
      throw Exception('Failed to update user: $errorMessage');
    }
  } catch (e) {
    throw Exception('An error occurred while updating user: ${e.toString()}');
  }
}