import 'dart:convert';

LoginModal loginModalFromJson(String str) =>
    LoginModal.fromJson(json.decode(str));

String loginModalToJson(LoginModal data) => json.encode(data.toJson());

class LoginModal {
  LoginModal({
    required this.success,
    required this.statusCode,
    required this.code,
    required this.message,
    this.data,
  });

  bool success;
  int statusCode;
  String code;
  String message;
  Data? data;

  factory LoginModal.fromJson(Map<String, dynamic> json) => LoginModal(
        success: json["success"],
        statusCode: json["statusCode"],
        code: json["code"],
        message: json["message"],
        data: json["success"] ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "code": code,
        "message": message,
        "data": success ? data!.toJson() : null,
      };
}

class Data {
  Data({
    required this.token,
    required this.id,
    required this.email,
    required this.fName,
    required this.lName,
    required this.username,
  });

  String token;
  int id;
  String email;
  String fName;
  String lName;
  String username;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        id: json["id"],
        email: json["email"],
        fName: json["firstName"],
        lName: json["lastName"],
        username: json["displayName"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "id": id,
        "email": email,
        "firstName": fName,
        "lastName": lName,
        "username": username,
      };
}
