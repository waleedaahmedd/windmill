import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

NotificationsModal notificationsModalFromJson(String str) =>
    NotificationsModal.fromJson(json.decode(str));

String notificationsModalToJson(NotificationsModal data) =>
    json.encode(data.toJson());

class NotificationsModal {
  NotificationsModal({
    required this.id,
    required this.userId,
    required this.message,
    required this.title,
    required this.createdOn,
  });

  String id;
  String userId;
  String message;
  String title;
  Timestamp createdOn;

  factory NotificationsModal.fromJson(Map<String, dynamic> json) =>
      NotificationsModal(
        id: json["id"],
        userId: json["user_id"],
        message: json["message"],
        title: json["title"],
        createdOn: json["created_on"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "message": message,
        "title": title,
        "created_on": createdOn,
      };
}
