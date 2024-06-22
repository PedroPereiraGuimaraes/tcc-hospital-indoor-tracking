class HistoricEntry {
  final DateTime inicialDate;
  final String room;

  HistoricEntry({required this.inicialDate, required this.room});

  factory HistoricEntry.fromJson(Map<String, dynamic> json) {
    return HistoricEntry(
      inicialDate: DateTime.parse(json['inicial_date']['\$date']),
      room: json['room'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inicial_date': {'\$date': inicialDate.toIso8601String()},
      'room': room,
    };
  }
}

class EquipmentWithHistory {
  final String name;
  final String patrimonio;
  final List<HistoricEntry> historic;

  EquipmentWithHistory({required this.name, required this.patrimonio, required this.historic});

  factory EquipmentWithHistory.fromJson(Map<String, dynamic> json) {
    return EquipmentWithHistory(
      name: json['name'],
      patrimonio: json['patrimonio'],
      historic: (json['historic'] as List)
          .map((entry) => HistoricEntry.fromJson(entry))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'patrimonio': patrimonio,
      'historic': historic.map((entry) => entry.toJson()).toList(),
    };
  }
}
