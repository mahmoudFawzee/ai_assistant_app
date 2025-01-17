import 'package:ai_assistant_app/data/models/task.dart';

abstract class TasksInterface {
  void addTask(TaskSpec taskSpec);
  void updateTask({
    required Task task,
    required Task oldTask,
  });
  void deleteTask(int taskId);
  Future<List<Task>> getAllTasks();
  Future<List<Task>> getUnCompletedTasks();
  Future<List<Task>> getCompletedTasks();
  void createTable();
  Future<bool> checkTableExists();
}
