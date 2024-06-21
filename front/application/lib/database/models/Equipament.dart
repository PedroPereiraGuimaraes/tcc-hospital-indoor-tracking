import 'package:form_field_validator/form_field_validator.dart';

class Equipament {
  String name;
  String patrimonio;
  bool maintenance;
  String? currentRoom; // Tornar opcional
  DateTime? currentDate; // Tornar opcional

  Equipament({
    required this.name,
    required this.patrimonio,
    required this.maintenance,
    this.currentRoom,
    this.currentDate,
  });

  // Método para desserializar JSON em um objeto Equipament
  factory Equipament.fromJson(Map<String, dynamic> json) {
    return Equipament(
      name: json['name'] as String,
      patrimonio: json['patrimonio'].toString(),
      maintenance: json['maintenance'] as bool,
      currentRoom: json['current_room']?.toString(), // Verificar null
      currentDate: json['current_date'] != null
          ? DateTime.parse(json['current_date']['\$date'] as String)
          : null, // Verificar null
    );
  }

  // Método para serializar um objeto Equipament em JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'patrimonio': patrimonio,
      'maintenance': maintenance,
      'current_room': currentRoom ?? "", // Retornar string vazia se null
      'current_date': currentDate != null
          ? {'\$date': currentDate!.toIso8601String()}
          : null, // Verificar null
    };
  }
}
