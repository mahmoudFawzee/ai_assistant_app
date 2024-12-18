import 'package:ai_assistant_app/data/models/message.dart';

abstract class MessagesInterface {
  Future<List<Message>> getConversationMessages(int conversationId);
  Future<Message> storeMessageLocally(Message message);
  Future<int> deleteMessage(int id);
  Future<int> deleteConversationMessages(int conversationId);
  Future<int> createMessagesTable();
}
