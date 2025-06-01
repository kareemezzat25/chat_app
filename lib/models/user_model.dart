class UserModel {
  String? id;
  String? email;
  String? age;
  String? username;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.age,
  });
  static fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "username": username, "email": email, "age": age};
  }
}
