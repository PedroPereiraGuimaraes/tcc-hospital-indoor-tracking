import 'dart:convert';
import 'package:http/http.dart' as http;

const String URL = 'http://localhost:8000';

Future<List<dynamic>> getReadAll() async {
  // var url = Uri.parse('http://10.0.2.2:8000/equipament/read-all');
  var url = Uri.parse("$URL/equipament/read-all");
  var response = await http.get(url);

  try {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Equipaments');
    }
  } catch (e) {
    return Future.error('Failed to $e');
  }
}

Future<dynamic> getReadOne(int patrimonio) async {
  // var url = Uri.parse(
  //     'http://10.0.2.2:8000/equipament/read-one?patrimonio=$patrimonio');
   var url = Uri.parse(
      '$URL/equipament/read-one?patrimonio=$patrimonio');
  var response = await http.get(url);

  try {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Equipament');
    }
  } catch (e) {
    throw Exception('Failed to $e');
  }
}

Future<List<dynamic>> getEquipmentsByCurrentRoom(String current_room) async {
  // var url = Uri.parse(
  //     'http://10.0.2.2:8000/equipament/get-equipments-by-current-room?current_room=$current_room');
  print('current_room: $current_room');
  var url = Uri.parse(
     '$URL/equipament/get-equipments-by-current-room?current_room=$current_room');
  var response = await http.get(url);

  try {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Equipaments');
    }
  } catch (e) {
    return Future.error('Failed to $e');
  }
}

Future<dynamic> getHistory(int patrimonio) async {
  // var url = Uri.parse(
  //     'http://10.0.2.2:8000/equipament/history?patrimonio=$patrimonio');
  var url = Uri.parse(
      '$URL/equipament/history?patrimonio=$patrimonio');
  var response = await http.get(url);

  try {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Equipament');
    }
  } catch (e) {
    throw Exception('Failed to $e');
  }
}

Future<dynamic> deleteEquipament(int patrimonio) async {
  // var url = Uri.parse(
  //     'http://10.0.2.2:8000/equipament/delete?patrimonio=$patrimonio');
  var url = Uri.parse(
     '$URL/equipament/delete?patrimonio=$patrimonio');
  var response = await http.delete(url);

  try {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete Equipament');
    }
  } catch (e) {
    throw Exception('Failed to delete $e');
  }
}
