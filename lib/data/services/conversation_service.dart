import 'package:ai_assistant_app/data/interface/conversation_interface.dart';
import 'package:ai_assistant_app/data/services/messages_service.dart';
import 'package:ai_assistant_app/data/key/sqflite_keys.dart';
import 'package:ai_assistant_app/data/models/conversation.dart';
import 'package:ai_assistant_app/data/services/database_helper.dart';

final class ConversationService implements ConversationInterface {
  final _databaseHelper = DatabaseHelper();
  final _messagesService = MessagesService();
  static const _tableName = SqfliteKeys.conversationTable;

  @override
  Future<int> deleteConversation(int id) async {
    //todo :note that here we need to delete all messages related to the conversation.
    await deleteConversationMessages(id);
    final result = await _databaseHelper.deleteRow(_tableName,
        where: '${SqfliteKeys.id}  = ?', whereArgs: [id]);
    return result;
  }

  @override
  Future<bool> deleteConversationMessages(int conversationId) async {
    final result = await _messagesService.deleteConversationMessages(
      conversationId,
    );
    //?this means that there is some thing deleted.
    return result > 0;
  }

  @override
  Future<List<Conversation>> getConversation() async {
    final conversations = await _databaseHelper.getRows(_tableName);
    return Conversation.fromJson(conversations);
  }

  @override
  Future<int> startNewConversation(Conversation conversation) async =>
      await _databaseHelper.insertRow(
        _tableName,
        conversation.toJson(),
      );

  @override
  Future<int> updateConversation({
    required int oldId,
    required Conversation conversation,
  }) async =>
      await _databaseHelper.updateRow(
        _tableName,
        //?this let us put the old id because toJson method
        //?doesn't have a id field so we provide it here.
        {SqfliteKeys.id: oldId, ...conversation.toJson()},
      );
}
