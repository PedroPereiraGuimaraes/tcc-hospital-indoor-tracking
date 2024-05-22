class User {
  Id? iId;
  String? name;
  String? email;
  String? password;
  String? registration;
  bool? isAdmin;

  User(
      {this.iId,
      this.name,
      this.email,
      this.password,
      this.registration,
      this.isAdmin});

  User.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    name = json['name'];
    email = json['email'];
    password = json['password'];
    registration = json['registration'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId!.toJson();
    }
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['registration'] = this.registration;
    data['isAdmin'] = this.isAdmin;
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
