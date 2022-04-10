import 'dart:convert';

class SocialLoginModal {
  SocialLoginModal({
    required this.token,
    required this.id,
    required this.email,
    required this.fName,
    required this.lName,
    required this.username,
  });

  String? token;
  int? id;
  String? email;
  String? fName;
  String? lName;
  String? username;
/*
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
      };*/
}
