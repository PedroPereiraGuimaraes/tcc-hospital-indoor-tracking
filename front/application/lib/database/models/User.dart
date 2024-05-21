class User {
  String? name;
  String? email;
  bool? isAdmin;
  String? password;
  String? registration;

  User({this.name, this.email, this.isAdmin, this.password, this.registration});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    isAdmin = json['isAdmin'];
    password = json['password'];
    registration = json['registration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['isAdmin'] = this.isAdmin;
    data['password'] = this.password;
    data['registration'] = this.registration;
    return data;
  }
}
