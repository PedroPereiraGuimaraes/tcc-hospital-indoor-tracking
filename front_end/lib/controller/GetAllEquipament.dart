import 'dart:convert';

import 'package:front_end/models/Equipament.dart';

import 'package:http/http.dart' as http;

class GetAllEquipament {
  Future<List<Equipament>> getAllEquipament() async {
    final response = await http.get(Uri.parse('http://localhost:8000/equipament/read-all'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // print da informacao 
      print(data);
      return data.map((e) => Equipament.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Equipaments');
    }
  }
}
