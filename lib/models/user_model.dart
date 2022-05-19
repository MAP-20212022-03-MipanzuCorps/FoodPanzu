class UserModel {
  String? userId, email, name, role;

  UserModel(
      {required this.userId,
      required this.email,
      required this.name,
      required this.role});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    userId = map['userId'];
    email = map['email'];
    name = map['name'];
    role = map['role'];
  }

  toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'role': role,
    };
  }
}
