import 'dart:convert';
import 'package:http/http.dart' as http;

const String URL = 'http://localhost:8000';
//const String URL = 'http://10.0.2.2:8000';

Future<List<dynamic>> getReadAll() async {
  var url = Uri.parse("$URL/equipment/read-all");
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

Future<dynamic> updateEquipament( String patrimonio,
     String name,
     DateTime lastMaintenance,
     DateTime nextMaintenance) async {
  var url = Uri.parse('$URL/equipment/update');
  var response = await http.put(url, body: {
    'patrimonio': patrimonio,
    'name': name,
    'last_maintenance': lastMaintenance.toIso8601String(),
    'next_maintenance': nextMaintenance.toIso8601String(),
  });
  try {
    if (response.statusCode == 200) {
      return "Success";
    } else {
      throw Exception('Failed to create Room');
    }
  } catch (e) {
    throw Exception('Failed to $e');
  }
    }



  



Future<dynamic> getReadOne(int patrimonio) async {
  var url = Uri.parse('$URL/equipment/read-one?patrimonio=$patrimonio');
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
Future<dynamic> createEquipment(String name, String patrimonio) async {
  var url = Uri.parse('$URL/equipment/create');
  final headers = {
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    "name": name,
    "patrimonio": patrimonio
  });
  var response = await http.post(url, headers: headers, body: body);
  try {
    if (response.statusCode == 201) {
      return "Success";
    } else {
      throw Exception('Failed to create Room');
    }
  } catch (e) {
    throw Exception('Failed to $e');
  }
}



Future<dynamic> deleteEquipament(int patrimonio) async {
  var url = Uri.parse('$URL/equipment/delete?patrimonio=$patrimonio');
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
