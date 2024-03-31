class User {
  final String name;
  String? cargo;

  User({required this.name, this.cargo});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      cargo: json['cargo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cargo': cargo,
    };
  }
}
