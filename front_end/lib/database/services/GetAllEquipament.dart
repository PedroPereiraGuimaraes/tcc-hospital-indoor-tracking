import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getAllEquipament() async {
  var url = Uri.parse('http://10.0.2.2:8000/equipament/read-all');
  var response = await http.get(url);

  try {
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Equipaments');
    }
  } catch (e) {
    return Future.error('Failed to $e');
  }
}
