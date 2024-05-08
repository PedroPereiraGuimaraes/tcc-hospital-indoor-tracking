
// model para os equipamentos 

class Equipament {
  int? id;
  String? name;
  String? patrimonio;
  String? maintenance;
  String? current_room;
  String? current_date;
  
  Equipament(
    {this.id,
      this.name,
      this.patrimonio,
      this.maintenance,
      this.current_room,
      this.current_date});

  Equipament.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    patrimonio = json['patrimonio'];
    maintenance = json['maintenance'];
    current_room = json['current_room'];
    current_date = json['current_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['patrimonio'] = patrimonio;
    data['maintenance'] = maintenance;
    data['current_room'] = current_room;
    data['current_date'] = current_date;
    return data;
  }
}