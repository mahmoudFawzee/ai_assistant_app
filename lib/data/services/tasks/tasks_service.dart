import 'dart:developer';

import 'package:ai_assistant_app/data/interface/tasks_interface.dart';
import 'package:ai_assistant_app/data/key/sqflite_keys.dart';
import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:ai_assistant_app/data/models/tasks/task.dart';
import 'package:ai_assistant_app/data/services/tasks/category_service.dart';
import 'package:ai_assistant_app/data/services/database_helper.dart';
import 'package:ai_assistant_app/data/services/tasks/date_time_formatter.dart';

final class TasksService implements TasksInterface {
  final _dbHelper = DatabaseHelper();
  final _categoryService = CategoryService();

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
  Future<List<Task>> getSpecificDayTasks(DateTime date) async {
    final result = await _dbHelper.getSpecificRows(
      SqfliteKeys.tasksTable,
      where: 'date = ?',
      whereArgs: [DateTimeFormatter.dateToString(date)],
    );
    return Task.fromJson(result);
  }

  @override
  Future<List<Task>> getSpecificDayCompletedTasks(DateTime date) async {
    final result = await _dbHelper.getSpecificRows(
      SqfliteKeys.tasksTable,
      where: 'date = ? && done = ?',
      whereArgs: [DateTimeFormatter.dateToString(date), 1],
    );
    return Task.fromJson(result);
  }

  @override
  Future<List<Task>> getSpecificDayUnCompletedTasks(DateTime date) async {
    final result = await _dbHelper.getSpecificRows(
      SqfliteKeys.tasksTable,
      where: 'date = ? && done = ?',
      whereArgs: [DateTimeFormatter.dateToString(date), 0],
    );
    return Task.fromJson(result);
  }

  @override
  Future addTask(TaskSpec taskSpec) async {
    final tableCreated = await checkTableExists();
    if (!tableCreated) {
      await createTable();
    }
    final id = await _dbHelper.insertRow(
      SqfliteKeys.tasksTable,
      taskSpec.toJson(),
    );
    log('id of added task : $id');
  }

  @override
  Future deleteTask(int taskId) async {
    final nOfRowDeleted = await _dbHelper.deleteRow(
      SqfliteKeys.tasksTable,
      where: 'id = ?',
      whereArgs: [taskId],
    );
    log('number of rows deleted : $nOfRowDeleted');
  }

  @override
  Future updateTask(Task task) async {
    final changes = await _dbHelper.updateRow(
      SqfliteKeys.tasksTable,
      task.toJson(),
    );
    log('number of changes happened : $changes');
  }

  @override
  Future createTable() async {
//     await _dbHelper.createTable(
//       '''
// CREATE TABLE ${SqfliteKeys.tasksTable}(
// ${SqfliteKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
// ${SqfliteKeys.category} TEXT,
// ${SqfliteKeys.title} TEXT,
// ${SqfliteKeys.description} TEXT,
// ${SqfliteKeys.done} INTEGER,
// ${SqfliteKeys.date} TEXT,
// ${SqfliteKeys.time} TEXT
// )
// '''
//     );
  }

  @override
  Future<bool> checkTableExists() async {
    return await _dbHelper.isTableExists(SqfliteKeys.tasksTable);
  }

  @override
  List<Task> getCategoryTasks(
    CategoryEnum category, {
    required List<Task> allTasks,
  }) =>
      _categoryService.filterTasks(category, allTasks: allTasks);
}
