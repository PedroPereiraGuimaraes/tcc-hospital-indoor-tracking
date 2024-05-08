import 'package:front_end/database/models/Historyc.dart';

class Equipament {
  String id;
  String name;
  String patrimonio;
  bool maintenance;
  String currentRoom;
  DateTime currentDate;
  List<Historic> historic;

  Equipament({
    required this.id,
    required this.name,
    required this.patrimonio,
    required this.maintenance,
    required this.currentRoom,
    required this.currentDate,
    required this.historic,
  });

  factory Equipament.fromJson(Map<String, dynamic> json) {
    return Equipament(
      id: json['_id']['\$oid'],
      name: json['name'],
      patrimonio: json['patrimonio'],
      maintenance: json['maintenance'],
      currentRoom: json['current_room'],
      currentDate: DateTime.parse(json['current_date']['\$date']),
      historic: (json['historic'] as List)
          .map((item) => Historic.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = {'\$oid': id};
    data['name'] = name;
    data['patrimonio'] = patrimonio;
    data['maintenance'] = maintenance;
    data['current_room'] = currentRoom;
    data['current_date'] = {'\$date': currentDate.toIso8601String()};
    data['historic'] = historic.map((item) => item.toJson()).toList();
    return data;
  }
}
