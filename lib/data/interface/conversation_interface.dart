import 'package:ai_assistant_app/data/models/conversation.dart';

abstract class ConversationInterface {
  Future<bool> startNewConversation(Conversation conversation);
  Future<bool> updateConversation(Conversation conversation);
  Future<bool> deleteConversation(int id);
  Future<List<Conversation>> getConversation();
}
