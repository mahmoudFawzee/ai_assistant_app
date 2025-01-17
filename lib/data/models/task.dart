import 'package:ai_assistant_app/data/key/sqflite_keys.dart';

final class Task {
  final String id;
  final TaskSpec taskSpec;
  const Task({
    required this.id,
    required this.taskSpec,
  });
  Map<String, dynamic> toJson() {
    return {
      SqfliteKeys.id: id,
      ...taskSpec.toJson(),
    };
  }

  factory Task._fromJson(Map<String, dynamic> json) {
    return Task(
      id: json[SqfliteKeys.id],
      taskSpec: TaskSpec._fromJson(json),
    );
  }
  static List<Task> fromJson(List<Map<String, dynamic>> jsonTasks) {
    final List<Task> tasks = [];
    for (var element in jsonTasks) {
      final task = Task._fromJson(element);
      tasks.add(task);
    }
    return tasks;
  }

  bool isMatch(Task task) {
    if (id != task.id) return false;
    if (!taskSpec.isMatch(task.taskSpec)) return false;

    return true;
  }
}

enum TaskCategory {
  education,
  work,
  entertainment,
  family,
  other,
}

final class TaskSpec {
  final bool done;
  final String title;
  final TaskCategory category;
  final String date;
  final String time;
  const TaskSpec({
    required this.date,
    required this.done,
    required this.time,
    required this.title,
    required this.category,
  });
  Map<String, dynamic> toJson() {
    return {
      SqfliteKeys.done: done ? 1 : 0,
      SqfliteKeys.category: _categoryToJson(),
      SqfliteKeys.title: title,
      SqfliteKeys.date: date,
      SqfliteKeys.time: time,
    };
  }

  bool isMatch(TaskSpec task) {
    if (date != task.date) return false;
    if (title != task.title) return false;
    if (time != task.time) return false;
    if (done != task.done) return false;
    if (category != task.category) return false;
    return true;
  }

  String _categoryToJson() {
    switch (category) {
      case TaskCategory.education:
        return SqfliteKeys.education;
      case TaskCategory.family:
        return SqfliteKeys.family;
      case TaskCategory.entertainment:
        return SqfliteKeys.entertainment;
      case TaskCategory.work:
        return SqfliteKeys.work;

      default:
        return SqfliteKeys.other;
    }
  }

  static TaskCategory _categoryFromJson(String value) {
    switch (value) {
      case SqfliteKeys.education:
        return TaskCategory.education;
      case SqfliteKeys.family:
        return TaskCategory.family;
      case SqfliteKeys.entertainment:
        return TaskCategory.entertainment;
      case SqfliteKeys.work:
        return TaskCategory.work;

      default:
        return TaskCategory.other;
    }
  }

  factory TaskSpec._fromJson(Map<String, dynamic> json) {
    return TaskSpec(
      date: json[SqfliteKeys.date],
      done: json[SqfliteKeys.done] == 1,
      time: json[SqfliteKeys.time],
      title: json[SqfliteKeys.title],
      category: _categoryFromJson(json[SqfliteKeys.category]),
    );
  }
}
