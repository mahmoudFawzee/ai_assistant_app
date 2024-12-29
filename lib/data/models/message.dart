import 'package:ai_assistant_app/data/key/sqflite_keys.dart';

final class Message {
  final int id;
  final int conversationId;
  final String title;
  final bool isMe;
  final String date;
  const Message({
    required this.isMe,
    required this.title,
    required this.id,
    required this.conversationId,
    required this.date,
  });
  Map<String, dynamic> toJson() => {
        SqfliteKeys.title: title,
        SqfliteKeys.isMe: isMe ? 1 : 0,
        SqfliteKeys.date: DateTime.now().toString(),
        SqfliteKeys.conversationId: conversationId,
      };

  factory Message._fromJson({required Map<String, dynamic> json}) => Message(
      isMe: json[SqfliteKeys.isMe] == 0 ? false : true,
      title: json[SqfliteKeys.title],
      id: json[SqfliteKeys.id],
      date: json[SqfliteKeys.date],
      conversationId: json[SqfliteKeys.conversationId]);
  static List<Message> fromJson({
    required List<Map<String, dynamic>> messages,
  }) {
    final List<Message> messagesList = [];
    for (var message in messages) {
      final aMessage = Message._fromJson(json: message);
      messagesList.add(aMessage);
    }
    return messagesList;
  }
}
