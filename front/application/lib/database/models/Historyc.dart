class HistoricEntry {
  DateTime inicialDate;
  String room;

  HistoricEntry({
    required this.inicialDate,
    required this.room,
  });

  // Método para desserializar JSON em um objeto HistoricEntry
  factory HistoricEntry.fromJson(Map<String, dynamic> json) {
    return HistoricEntry(
      inicialDate: DateTime.parse(json['inicial_date']['\$date'] as String),
      room: json['room'].toString(),
    );
  }

  // Método para serializar um objeto HistoricEntry em JSON
  Map<String, dynamic> toJson() {
    return {
      'inicial_date': {
        '\$date': inicialDate.toIso8601String(),
      },
      'room': room,
    };
  }
}

class EquipmentWithHistory {
  String name;
  List<HistoricEntry> historic;

  EquipmentWithHistory({
    required this.name,
    required this.historic,
  });

  // Método para desserializar JSON em um objeto EquipmentWithHistory
  factory EquipmentWithHistory.fromJson(Map<String, dynamic> json) {
    var historicList = json['historic'] as List<dynamic>;
    List<HistoricEntry> historicEntries = historicList.map((entry) => HistoricEntry.fromJson(entry)).toList();

    return EquipmentWithHistory(
      name: json['name'] as String,
      historic: historicEntries,
    );
  }

  // Método para serializar um objeto EquipmentWithHistory em JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'historic': historic.map((entry) => entry.toJson()).toList(),
    };
  }
}