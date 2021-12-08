import 'dart:convert';

UserModal userModalFromJson(String str) => UserModal.fromJson(json.decode(str));

String userModalToJson(UserModal data) => json.encode(data.toJson());

class UserModal {
  UserModal({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.role,
    this.avatarUrl,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String username;
  String role;
  String? avatarUrl;

  factory UserModal.fromJson(Map<String, dynamic> json) => UserModal(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        role: json["role"],
        avatarUrl: json["avatar_url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "role": role,
        "avatar_url": avatarUrl ?? "",
      };
}
