import 'package:ai_assistant_app/data/key/sqflite_keys.dart';

final class MessageSpec {
  final String title;
  final bool isMe;
  final int conversationId;
  final String date;
  const MessageSpec({
    required this.conversationId,
    required this.isMe,
    required this.title,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        SqfliteKeys.title: title,
        SqfliteKeys.isMe: isMe ? 1 : 0,
        SqfliteKeys.conversationId: conversationId,
        SqfliteKeys.date: date,
      };

  factory MessageSpec.fromJson({required Map<String, dynamic> json}) =>
      MessageSpec(
        isMe: json[SqfliteKeys.isMe] == 0 ? false : true,
        title: json[SqfliteKeys.title],
        conversationId: json[SqfliteKeys.conversationId],
        date: json[SqfliteKeys.date],
      );
}
