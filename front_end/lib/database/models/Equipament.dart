class Equipament {
  String id;
  String name;
  String patrimonio;
  bool maintenance;
  String currentRoom;
  String currentDate;

  Equipament({
    required this.id,
    required this.name,
    required this.patrimonio,
    required this.maintenance,
    required this.currentRoom,
    required this.currentDate,
  });

  factory Equipament.fromJson(Map<String, dynamic> json) {
    return Equipament(
      id: json['_id']['\$oid'],
      name: json['name'],
      patrimonio: json['patrimonio'],
      maintenance: json['maintenance'],
      currentRoom: json['current_room'],
      currentDate: json['current_date']['\$date'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = {'\$oid': id};
    data['name'] = name;
    data['patrimonio'] = patrimonio;
    data['maintenance'] = maintenance;
    data['current_room'] = currentRoom;
    data['current_date'] = {'\$date': currentDate};
    return data;
  }
}
