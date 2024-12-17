import 'package:ai_assistant_app/data/key/sqflite_keys.dart';

final class Conversation {
  final int id;
  final String title;
  const Conversation({
    required this.id,
    required this.title,
  });
  Map<String, dynamic> toJson() => {
        SqfliteKeys.id: id,
        SqfliteKeys.title: title,
      };

  factory Conversation._fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json[SqfliteKeys.id],
      title: json[SqfliteKeys.title],
    );
  }

  static List<Conversation> fromJson(List<Map<String, dynamic>> conversations) {
    final List<Conversation> conversationsList = [];
    for (var conversation in conversations) {
      final aConversation = Conversation._fromJson(conversation);
      conversationsList.add(aConversation);
    }
    return conversationsList;
  }
}
