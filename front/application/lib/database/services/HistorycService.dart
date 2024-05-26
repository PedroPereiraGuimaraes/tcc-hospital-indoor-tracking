import 'dart:convert';
import 'package:http/http.dart' as http;

const String URL = 'http://localhost:8000';

Future<List<dynamic>> getEquipamentWithHistoric() async {
  final response = await http.get(Uri.parse('$URL/equipament/read-all'));

  if (response.statusCode == 200) {
    var equipaments = jsonDecode(response.body);
    List<dynamic> equipamentWithHistoricList = [];
     for (var equipament in equipaments) {
    var name = equipament['name'];
    var historic = equipament['historic'];
    if (historic != null) {
      for (var h in historic) {
        h['equipament_name'] = name;
      }
      equipamentWithHistoricList.addAll(historic);
    }
  }
    return equipamentWithHistoricList;
  } else {
    throw Exception('Failed to load historic data');
  }
}
