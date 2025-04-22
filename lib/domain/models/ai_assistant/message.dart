import 'package:ai_assistant_app/data/key/sqflite_keys.dart';
import 'package:ai_assistant_app/domain/models/ai_assistant/message_spec.dart';

final class Message {
  final int id;
  final MessageSpec messageSpec;
  const Message({
    required this.messageSpec,
    required this.id,
  });
 

  factory Message._fromJson({required Map<String, dynamic> json}) => Message(
        messageSpec: MessageSpec.fromJson(json: json),
        id: json[SqfliteKeys.id],        
      );
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
