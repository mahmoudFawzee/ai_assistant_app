import 'package:ai_assistant_app/domain/models/ai_assistant/message.dart';
import 'package:ai_assistant_app/domain/models/ai_assistant/message_spec.dart';

abstract class MessagesInterface {
  Future createMessageTable(int conversationId);
  Future dropTable(int conversationId);
  Future<List<Message>> getConversationMessages(int conversationId);
  Future<int> storeMessageLocally(MessageSpec messageSpec);
  Future<int> deleteMessage({required int conversationId, required int id});
  Future<int> deleteConversationMessages(int conversationId);
  Future<List<Message>> getRangeMessages(
    int conversationId, {
    required int offset,
    required int limit,
  });
  Future<Message> getMessage({
    required int conversationId,
    required int messageId,
  });

  Future<int?> getLastMessageId(int conversationId);
  Future<int> getNumberOfMessages(int conversationId);
}
