import 'package:ai_assistant_app/data/models/message.dart';

abstract class MessagesInterface {
  Future<List<Message>> getConversationMessages(int conversationId);
  Future<bool> storeMessageLocally(Message message);
  Future<bool> deleteMessage(int id);
  Future<bool> createMessagesTable();
}
