import 'dart:developer';

import 'package:ai_assistant_app/data/interface/tasks_interface.dart';
import 'package:ai_assistant_app/data/key/sqflite_keys.dart';
import 'package:ai_assistant_app/data/models/task.dart';
import 'package:ai_assistant_app/data/services/database_helper.dart';

final class TasksService implements TasksInterface {
  final _dbHelper = DatabaseHelper();

  @override
  Future<List<Task>> getAllTasks() async {
    final result = await _dbHelper.getRows(
      SqfliteKeys.tasksTable,
    );
    return Task.fromJson(result);
  }

  @override
  Future<List<Task>> getCompletedTasks() async {
    final result = await _dbHelper.getSpecificRows(
      SqfliteKeys.tasksTable,
      where: 'done = ?',
      whereArgs: [1],
    );
    return Task.fromJson(result);
  }

  @override
  Future<List<Task>> getUnCompletedTasks() async {
    final result = await _dbHelper.getSpecificRows(
      SqfliteKeys.tasksTable,
      where: 'done = ?',
      whereArgs: [0],
    );
    return Task.fromJson(result);
  }

  @override
  void addTask(TaskSpec taskSpec) async {
    final id = await _dbHelper.insertRow(
      SqfliteKeys.tasksTable,
      taskSpec.toJson(),
    );
    log('id of added task : $id');
  }

  @override
  void deleteTask(int taskId) async {
    final nOfRowDeleted = await _dbHelper.deleteRow(
      SqfliteKeys.tasksTable,
      where: 'id = ?',
      whereArgs: [taskId],
    );
    log('number of rows deleted : $nOfRowDeleted');
  }

  @override
  void updateTask({required Task task, required Task oldTask}) async {
    if (!oldTask.isMatch(task)) return;
    final changes = await _dbHelper.updateRow(
      SqfliteKeys.tasksTable,
      task.toJson(),
    );
    log('number of changes happened : $changes');
  }

  @override
  void createTable() async {
    await _dbHelper.createTable(
      '''
CREATE TABLE ${SqfliteKeys.tasksTable}(
${SqfliteKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
${SqfliteKeys.category} TEXT,
${SqfliteKeys.title} TEXT,
${SqfliteKeys.done} INTEGER,
${SqfliteKeys.date} TEXT,
${SqfliteKeys.time} TEXT
)
''',
    );
  }

  @override
  Future<bool> checkTableExists() async {
    return await _dbHelper.isTableExists(SqfliteKeys.tasksTable);
  }
}
