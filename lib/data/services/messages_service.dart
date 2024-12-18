import 'package:ai_assistant_app/data/interface/messages_interface.dart';
import 'package:ai_assistant_app/data/key/sqflite_keys.dart';
import 'package:ai_assistant_app/data/models/message.dart';
import 'package:ai_assistant_app/data/services/database_helper.dart';

final class MessagesService implements MessagesInterface {
  final _databaseHelper = DatabaseHelper();
  static const _tableName = SqfliteKeys.messagesTable;
  //!here we will load specific conversation messages.
  @override
  Future<List<Message>> getConversationMessages(int conversationId) async {
    final messagesList = await _databaseHelper.getSpecificRows(
      _tableName,
      where: '${SqfliteKeys.conversationId}=?',
      whereArgs: [conversationId],
    );
    return Message.fromJson(messages: messagesList);
  }

  @override
  Future<int> storeMessageLocally(Message message) async =>
      await _databaseHelper.insertRow(
        _tableName,
        message.toJson(),
      );

  @override
  Future<int> deleteMessage(int id) async => await _databaseHelper
      .deleteRow(_tableName, where: 'id  = ?', whereArgs: [id]);

//   @override
//   Future<int> createMessagesTable() async =>
//       await _databaseHelper.createTable('''
// CREATE TABLE messages(
// ${SqfliteKeys.id}:INTEGER PRIMARY KEY AUTOINCREMENT,
// ${SqfliteKeys.conversationId}:INTEGER,
// ${SqfliteKeys.title}:TEXT,
// ${SqfliteKeys.isMe}:INTEGER,
// ${SqfliteKeys.date}:TEXT,
// ${SqfliteKeys.time}:TEXT
// )
// ''');

  @override
  Future<int> deleteConversationMessages(int conversationId) async =>
      await _databaseHelper.deleteRow(_tableName,
          where: '${SqfliteKeys.conversationId}  = ?',
          whereArgs: [conversationId]);

  @override
  Future<int> createMessagesTable() {
    // TODO: implement createMessagesTable
    throw UnimplementedError();
  }
}
