import 'dart:convert';
import 'package:http/http.dart' as http;

const String URL = 'http://localhost:8000';
//const String URL = 'http://10.0.2.2:8000';

Future<Map<String, List<dynamic>>> getEquipamentWithHistoric() async {
  final response = await http.get(Uri.parse('$URL/equipament/read-all'));

  if (response.statusCode == 200) {
    var equipaments = jsonDecode(response.body);
    Map<String, List<dynamic>> equipamentWithHistoricMap = {};
    
    for (var equipament in equipaments) {
      var name = equipament['name'];
      var historic = equipament['historic'];
      if (historic != null) {
        if (!equipamentWithHistoricMap.containsKey(name)) {
          equipamentWithHistoricMap[name] = [];
        }
        for (var h in historic) {
          h['equipament_name'] = name;
          equipamentWithHistoricMap[name]!.add(h);
        }
      }
    }
    print(equipamentWithHistoricMap);
    return equipamentWithHistoricMap;
  } else {
    throw Exception('Failed to load historic data');
  }
}
