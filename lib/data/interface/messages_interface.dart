import 'package:ai_assistant_app/data/models/message.dart';

abstract class MessagesInterface {
  Future<List<Message>> getConversationMessages(int conversationId);
  Future<int> storeMessageLocally(Message message);
  Future<int> deleteMessage({required int conversationId, required int id});
  Future<int> deleteConversationMessages(int conversationId);
  Future<List<Message>> getRangeMessages(
    int conversationId, {
    required int start,
    required int end,
  });
  Future createMessageTable(int conversationId);
  Future<int?> getLastMessageId(int conversationId);
}
