import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String id;
  String message;
  String userId;
  DateTime date;

  MessageModel({
    required this.date,
    required this.message,
    required this.userId,
    this.id = "",
  });

  static fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      userId: json['userId'],
      date: (json['date'] as Timestamp).toDate(),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "date": date, "message": message, "userId": userId};
  }
}
