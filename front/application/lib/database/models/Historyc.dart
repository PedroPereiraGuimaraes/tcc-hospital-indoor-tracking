class Historic {
  DateTime inicialDate;
  String room;

  Historic({
    required this.inicialDate,
    required this.room,
  });

  factory Historic.fromJson(Map<String, dynamic> json) {
    return Historic(
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
