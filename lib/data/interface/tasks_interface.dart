import 'package:ai_assistant_app/data/models/task.dart';

abstract class TasksInterface {
  void addTask(Task task);
  void updateTask({required Task task, required Task oldTask});
  void deleteTask(int taskId);
  void getTasks();
}
