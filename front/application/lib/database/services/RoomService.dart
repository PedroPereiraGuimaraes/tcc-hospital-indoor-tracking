import 'dart:convert';
import 'package:http/http.dart' as http;

const String URL = 'http://localhost:8000';

Future<List<dynamic>> getReadAll() async {
  var url = Uri.parse("$URL/room/read-all");
  var response = await http.get(url);

  try {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Room');
    }
  } catch (e) {
    return Future.error('Failed to $e');
  }
}
Future<dynamic> createRoom(String name) async {
  var url = Uri.parse('$URL/room/create');
  final headers = {
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    "name": name,
  });
  var response = await http.post(url, headers: headers, body: body);

  try {
    if (response.statusCode == 200) {
      print('Room created');
      return "Success";
    } else {
      throw Exception('Failed to create Room');
    }
  } catch (e) {
    throw Exception('Failed to $e');
  }
}
Future<dynamic> getReadOne(String name) async {
  var url = Uri.parse('$URL/room/read-one?name=$name');
  var response = await http.get(url);

  try {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Room');
    }
  } catch (e) {
    throw Exception('Failed to $e');
  }
}

Future<dynamic> deleteRoom(String uuid) async {
  var url = Uri.parse('$URL/room/delete-room?uuid=$uuid');
  var response = await http.delete(url);

  try {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete Room');
    }
  } catch (e) {
    throw Exception('Failed to $e');
  }
}
