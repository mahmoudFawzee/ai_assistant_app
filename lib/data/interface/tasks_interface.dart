import 'package:ai_assistant_app/data/models/task.dart';

abstract class TasksInterface {
  void addTask(TaskSpec taskSpec);
  void updateTask(Task task);
  void deleteTask(int taskId);
  Future<List<Task>> getAllTasks();
  Future<List<Task>> getUnCompletedTasks();
  Future<List<Task>> getCompletedTasks();
  Future<List<Task>> getSpecificDayTasks(DateTime date);
  Future<List<Task>> getSpecificDayUnCompletedTasks(DateTime date);
  Future<List<Task>> getSpecificDayCompletedTasks(DateTime date);

  void createTable();
  Future<bool> checkTableExists();
}
