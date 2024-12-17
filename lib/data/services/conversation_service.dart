import 'package:ai_assistant_app/data/interface/conversation_interface.dart';
import 'package:ai_assistant_app/data/key/sqflite_keys.dart';
import 'package:ai_assistant_app/data/models/conversation.dart';
import 'package:ai_assistant_app/data/services/database_helper.dart';

final class ConversationService implements ConversationInterface {
  final _databaseHelper = DatabaseHelper();
  static const _tableName = SqfliteKeys.conversationTable;
  @override
  Future<bool> deleteConversation(int id) async =>
      await _databaseHelper.deleteRow(
        _tableName,
        id,
      );

  @override
  Future<List<Conversation>> getConversation() async {
    final conversations = await _databaseHelper.getRows(_tableName);
    return Conversation.fromJson(conversations);
  }

  @override
  Future<bool> startNewConversation(Conversation conversation) async =>
      await _databaseHelper.insertRow(
        _tableName,
        conversation.toJson(),
      );

  @override
  Future<bool> updateConversation(Conversation conversation) async =>
      await _databaseHelper.updateRow(
        _tableName,
        conversation.toJson(),
      );
}
