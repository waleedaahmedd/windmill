import 'dart:convert';

RegisterModal registerModalFromJson(String str) =>
    RegisterModal.fromJson(json.decode(str));

String registerModalToJson(RegisterModal data) => json.encode(data.toJson());

class RegisterModal {
  RegisterModal({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.avatarUrl,
    this.code,
    this.message,
    this.data,
  });

  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? username;
  String? avatarUrl;
  String? code;
  String? message;
  ErrorData? data;

  factory RegisterModal.fromJson(Map<String, dynamic> json) => RegisterModal(
        id: json["id"] ?? null,
        email: json["email"] ?? null,
        firstName: json["first_name"] ?? null,
        lastName: json["last_name"] ?? null,
        username: json["username"] ?? null,
        avatarUrl: json["avatar_url"] ?? null,
        code: json["code"] ?? null,
        message: json["message"] ?? null,
        data: json["data"] == null ? null : ErrorData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "email": email ?? null,
        "first_name": firstName ?? null,
        "last_name": lastName ?? null,
        "username": username ?? null,
        "avatar_url": avatarUrl ?? null,
        "code": code ?? null,
        "message": message ?? null,
        "data": data == null ? null : data!.toJson(),
      };
}

class ErrorData {
  ErrorData({
    required this.status,
  });

  int status;

  factory ErrorData.fromJson(Map<String, dynamic> json) => ErrorData(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
