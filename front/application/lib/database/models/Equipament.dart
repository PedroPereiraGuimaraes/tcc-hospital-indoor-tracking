class Equipament {
  String name;
  String patrimonio;
  bool maintenance;
  String currentRoom;
  DateTime currentDate;

  Equipament({
    required this.name,
    required this.patrimonio,
    required this.maintenance,
    required this.currentRoom,
    required this.currentDate,
  });

  // Método para desserializar JSON em um objeto Equipment
  factory Equipament.fromJson(Map<String, dynamic> json) {
    return Equipament(
      name: json['name'] as String,
      patrimonio: json['patrimonio'].toString(),
      maintenance: json['maintenance'] as bool,
      currentRoom: json['current_room'].toString(),
      currentDate: DateTime.parse(json['current_date']['\$date'] as String),
    );
  }

  // Método para serializar um objeto Equipment em JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'patrimonio': patrimonio,
      'maintenance': maintenance,
      'current_room': currentRoom,
      'current_date': {
        '\$date': currentDate.toIso8601String(),
      },
    };
  }
}