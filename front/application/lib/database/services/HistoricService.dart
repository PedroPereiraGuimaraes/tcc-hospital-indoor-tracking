import 'dart:convert';
import 'package:http/http.dart' as http;

const String URL = 'http://localhost:8000';
//const String URL = 'http://10.0.2.2:8000';

Future<List<dynamic>> getEquipamentWithHistoric() async {
  final response = await http.get(Uri.parse('$URL/equipment/history'));

  if (response.statusCode == 200) {
    var equipaments = jsonDecode(response.body);
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load historic data');
  }
}
