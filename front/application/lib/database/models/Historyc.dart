class Historic {
  InicialDate? inicialDate;
  String? room;
  String? equipamentName;

  Historic({this.inicialDate, this.room, this.equipamentName});

  Historic.fromJson(Map<String, dynamic> json) {
    inicialDate = json['inicial_date'] != null
        ? new InicialDate.fromJson(json['inicial_date'])
        : null;
    room = json['room'];
    equipamentName = json['equipament_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.inicialDate != null) {
      data['inicial_date'] = this.inicialDate!.toJson();
    }
    data['room'] = this.room;
    data['equipament_name'] = this.equipamentName;
    return data;
  }
}

class InicialDate {
  String? date;

  InicialDate({this.date});

  factory InicialDate.fromJson(Map<String, dynamic> json) {
    // Verifica se o JSON contém a chave "$date"
    if (json.containsKey("\$date")) {
      return InicialDate(date: json["\$date"]);
    } else {
      throw FormatException('Invalid date format');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$date'] = this.date;
    return data;
  }
}
