class Equipament {
  Id? iId;
  String? name;
  String? patrimonio;
  bool? maintenance;
  String? currentRoom;
  CurrentDate? currentDate;
  List<Historic>? historic;

  Equipament(
      {this.iId,
      this.name,
      this.patrimonio,
      this.maintenance,
      this.currentRoom,
      this.currentDate,
      this.historic});

  Equipament.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    name = json['name'];
    patrimonio = json['patrimonio'];
    maintenance = json['maintenance'];
    currentRoom = json['current_room'];
    currentDate = json['current_date'] != null
        ? new CurrentDate.fromJson(json['current_date'])
        : null;
    if (json['historic'] != null) {
      historic = <Historic>[];
      json['historic'].forEach((v) {
        historic!.add(new Historic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId!.toJson();
    }
    data['name'] = this.name;
    data['patrimonio'] = this.patrimonio;
    data['maintenance'] = this.maintenance;
    data['current_room'] = this.currentRoom;
    if (this.currentDate != null) {
      data['current_date'] = this.currentDate!.toJson();
    }
    if (this.historic != null) {
      data['historic'] = this.historic!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Id {
  String? oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$oid'] = this.oid;
    return data;
  }
}

class CurrentDate {
  String? date;

  CurrentDate({this.date});

  CurrentDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}

class Historic {
  CurrentDate? inicialDate;
  String? room;

  Historic({this.inicialDate, this.room});

  Historic.fromJson(Map<String, dynamic> json) {
    inicialDate = json['inicial_date'] != null
        ? new CurrentDate.fromJson(json['inicial_date'])
        : null;
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.inicialDate != null) {
      data['inicial_date'] = this.inicialDate!.toJson();
    }
    data['room'] = this.room;
    return data;
  }
}
