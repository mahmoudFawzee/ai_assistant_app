import 'dart:developer';

import 'package:ai_assistant_app/data/interface/messages_interface.dart';
import 'package:ai_assistant_app/data/key/sqflite_keys.dart';
import 'package:ai_assistant_app/data/models/message.dart';
import 'package:ai_assistant_app/data/models/message_spec.dart';
import 'package:ai_assistant_app/data/services/database_helper.dart';

final class MessagesService implements MessagesInterface {
  final _databaseHelper = DatabaseHelper();
  String _tableName(int conversationId) =>
      '${SqfliteKeys.messagesTable}$conversationId';
  //!here we will load specific conversation messages.
  @override
  Future<List<Message>> getConversationMessages(int conversationId) async {
    final messagesList = await _databaseHelper.getSpecificRows(
      _tableName(conversationId),
      where: '${SqfliteKeys.conversationId}=?',
      whereArgs: [conversationId],
    );
    return Message.fromJson(messages: messagesList);
  }

//*we need here to return the message to emit it in the state.
  @override
  Future<int> storeMessageLocally(MessageSpec messageSpec) async {
    final messageId = await _databaseHelper.insertRow(
      _tableName(messageSpec.conversationId),
      messageSpec.toJson(),
    );
    //todo: get message stored.
    return messageId;
  }

  @override
  Future<int> deleteMessage({
    required int conversationId,
    required int id,
  }) async =>
      await _databaseHelper.deleteRow(_tableName(conversationId),
          where: 'id  = ?', whereArgs: [id]);

  @override
  Future<int> deleteConversationMessages(int conversationId) async =>
      await _databaseHelper.deleteRow(_tableName(conversationId),
          where: '${SqfliteKeys.conversationId}  = ?',
          whereArgs: [conversationId]);

  @override
  Future<List<Message>> getRangeMessages(
    int conversationId, {
    required int offset,
    required int limit,
  }) async {
    //?result => get messages from limit : limit*pageNumber.
    log('messages state : offset : $offset limit : $limit');
    final result = await _databaseHelper.getRowsInRange(
      tableName: _tableName(conversationId),
      orderedBy: 'id DESC',
      offset: offset,
      limit: limit,
    );
    log('n of rows :${result.length}');
    if (result.isEmpty) return [];
    return Message.fromJson(messages: result);
  }

  @override
  Future createMessageTable(int conversationId) async {
    final tableName = '${SqfliteKeys.messagesTable}$conversationId';
    await _databaseHelper.createTable(
      '''
CREATE TABLE $tableName(
${SqfliteKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
${SqfliteKeys.conversationId} INTEGER,
${SqfliteKeys.title} TEXT,
${SqfliteKeys.isMe} INTEGER,
${SqfliteKeys.date} TEXT,
${SqfliteKeys.time} TEXT
)
''',
    );
  }

  @override
  Future<int?> getLastMessageId(int conversationId) async {
    return await _databaseHelper.getTableLastItemId(_tableName(
      conversationId,
    ));
  }

  @override
  Future dropTable(int conversationId) async {
    await _databaseHelper.dropTable(_tableName(conversationId));
  }

  @override
  Future<int> getNumberOfMessages(int conversationId) async {
    final tableName = '${SqfliteKeys.messagesTable}$conversationId';
    return await _databaseHelper.getNumberOfRows(tableName);
  }

  @override
  Future<Message> getMessage(
      {required int conversationId, required int messageId}) async {
    final tableName = '${SqfliteKeys.messagesTable}$conversationId';
    final result = await _databaseHelper.getSpecificRows(
      tableName,
      where: 'id = ?',
      whereArgs: [messageId],
    );
    return Message.fromJson(messages: result).first;
  }
}
