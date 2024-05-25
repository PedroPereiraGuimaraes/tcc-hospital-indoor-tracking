class Room {
  Id? iId;
  String? name;
  List<Equipments>? equipments;

  Room({this.iId, this.name, this.equipments});

  Room.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    name = json['name'];
    if (json['equipments'] != null) {
      equipments = <Equipments>[];
      json['equipments'].forEach((v) {
        equipments!.add(new Equipments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId!.toJson();
    }
    data['name'] = this.name;
    if (this.equipments != null) {
      data['equipments'] = this.equipments!.map((v) => v.toJson()).toList();
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

class Equipments {
  String? equipment;
  String? patrimonio;

  Equipments({this.equipment, this.patrimonio});

  Equipments.fromJson(Map<String, dynamic> json) {
    equipment = json['equipment'];
    patrimonio = json['patrimonio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['equipment'] = this.equipment;
    data['patrimonio'] = this.patrimonio;
    return data;
  }
}
