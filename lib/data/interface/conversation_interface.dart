import 'package:ai_assistant_app/data/models/ai_assistant/conversation.dart';

abstract class ConversationInterface {
  Future<int> startNewConversation(Conversation conversation);
  Future<int> updateConversation({
    required int oldId,
    required Conversation conversation,
  });
  Future<int> deleteConversation(int id);
  Future deleteConversationMessages(int conversationId);
  Future<List<Conversation>> getConversations();
}
