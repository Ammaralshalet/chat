import 'dart:convert';

class ChatModel {
  String name;
  String image;
  String message;
  String date;
  int unreadMessageCount;
  int id;

  ChatModel({
    required this.name,
    required this.image,
    required this.message,
    required this.date,
    required this.unreadMessageCount,
    required this.id,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      message: map['message'] ?? '',
      date: map['date'] ?? '',
      unreadMessageCount: map['unread_message_count'] is String
          ? int.tryParse(map['unread_message_count']) ?? 0
          : map['unread_message_count'] ?? 0,
      id: map['id'] is String ? int.tryParse(map['id']) ?? 0 : map['id'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'message': message,
      'date': date,
      'unread_message_count': unreadMessageCount,
      'id': id,
    };
  }

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
