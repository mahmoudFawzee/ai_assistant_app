import 'dart:developer';

import 'package:ai_assistant_app/data/interface/database_interface.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ai_assistant_app/data/key/sqflite_keys.dart';
import 'package:path/path.dart';

final class DatabaseHelper implements DatabaseInterface {
  static Database? _database;

  //?singleton pattern to make the database just one instance in
  //?the whole application.

  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  //todo:initialize the data base

  Future<Database> _initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'ai_assistant.db');
    
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

//?here when we start the chat we will create the history data base.
  Future _onCreate(Database db, int version) async {
    await createTable(db, '''
CREATE TABLE conversations(
${SqfliteKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
${SqfliteKeys.title} TEXT
)
''');
    await createTable(db, '''
CREATE TABLE messages(
${SqfliteKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
${SqfliteKeys.conversationId} INTEGER,
${SqfliteKeys.title} TEXT,
${SqfliteKeys.isMe} INTEGER,
${SqfliteKeys.date} TEXT,
${SqfliteKeys.time} TEXT
)
''');
  }

  Future<Database> get database async {
    log('get db');
    if (_database != null) return _database!;
    log('db =null db');
    _database = await _initDb();
    return _database!;
  }

  @override
  Future<bool> isTableExists(String tableName) async {
    final db = await database;
    final result = await db.rawQuery(
      '''
    SELECT name 
    FROM sqlite_master 
    WHERE type = 'table' AND name = ?;
    ''',
      [tableName],
    );
    return result.isNotEmpty;
  }

  //?query is the sql command to create the new table.
  @override
  Future createTable(Database db, String query) async {
    await db.execute(query);
  }

  @override
  Future<int> deleteRow(
    String tableName, {
    required String where,
    required List<Object?> whereArgs,
  }) async {
    final db = await database;
    final result =
        await db.delete(tableName, where: where, whereArgs: whereArgs);
    return result;
  }

  @override
  Future<int> insertRow(String tableName, Map<String, dynamic> row) async {
    final db = await database;
    final result = await db.insert(tableName, row);
    return result;
  }

  @override
  Future<int> updateRow(String tableName, Map<String, dynamic> row) async {
    final db = await database;
    final id = row[SqfliteKeys.id];
    final result = await db.update(
      tableName,
      row,
      where: 'id=?',
      whereArgs: [id],
    );
    return result;
  }

  @override
  Future<List<Map<String, dynamic>>> getRows(String tableName) async {
    log('get data base');
    final db = await database;
    log('database got $tableName');
    final result = await db.query(tableName);
    return result;
  }

  @override
  Future<List<Map<String, dynamic>>> getSpecificRows(
    String tableName, {
    required String where,
    required List<Object?> whereArgs,
  }) async {
    final db = await database;
    final result = await db.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
    return result;
  }
}
