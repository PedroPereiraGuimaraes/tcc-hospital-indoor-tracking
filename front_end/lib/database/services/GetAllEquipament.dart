import 'dart:convert';
import 'package:front_end/models/Equipament.dart';
import 'package:http/http.dart' as http;

// buscar lista de equipamentos cadastrados
Future<List<Equipament>> getAllEquipament() async {
  var url = Uri.parse('http://10.0.2.2:8000/equipament/read-all');
  var response = await http.get(url);

  try {
    if (response.statusCode == 200) {
      print('Equipaments: ${jsonDecode(response.body)}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Equipaments');
    }
  }catch(e){
    print('erroooooo to $e');
    return Future.error('Failed to $e');
}
} 


