import 'package:ai_assistant_app/data/key/sqflite_keys.dart';
import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:ai_assistant_app/data/services/tasks/date_time_formatter.dart';
import 'package:flutter/material.dart';

final class Task {
  final int id;
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

  factory Task.confirmTaskFinished(Task task) {
    final spec = task.taskSpec;
    return Task(
      id: task.id,
      taskSpec: TaskSpec(
        date: spec.date,
        done: true,
        time: spec.time,
        title: spec.title,
        description: spec.description,
        category: spec.category,
      ),
    );
  }
  factory Task.oneTaskFromJson(Map<String, dynamic> json) {
    return Task(
      id: json[SqfliteKeys.id],
      taskSpec: TaskSpec._fromJson(json),
    );
  }

  static List<Task> fromJson(List<Map<String, dynamic>> jsonTasks) {
    final List<Task> tasks = [];
    for (var element in jsonTasks) {
      final task = Task.oneTaskFromJson(element);
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

final class TaskSpec {
  final bool done;
  final String title;
  final String description;
  final CategoryEnum category;
  final DateTime date;
  final TimeOfDay _time;
  const TaskSpec({
    required this.date,
    required this.done,
    required TimeOfDay time,
    required this.title,
    required this.description,
    required this.category,
  }) : _time = time;
  Map<String, dynamic> toJson() {
    return {
      SqfliteKeys.done: done ? 1 : 0,
      SqfliteKeys.category: Category.categoryToJson(category),
      SqfliteKeys.title: title,
      SqfliteKeys.description: description,
      SqfliteKeys.date: DateTimeFormatter.dateToString(date),
      SqfliteKeys.time: DateTimeFormatter.timeToString(date),
    };
  }

  get time => _time;
  String stringTime() {
    return '${_handelHour(_time.hour).toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')} ${_amOrPm(_time.hour)}';
  }

  int _handelHour(int hour) {
    if (hour == 0) return 12;
    if (hour > 12) return hour - 12;
    return hour;
  }

  String _amOrPm(int hour) {
    if (hour > 12) return 'PM';
    return 'AM';
  }

  String stringDate() =>
      '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}';
  bool isMatch(TaskSpec task) {
    if (date != task.date) return false;
    if (title != task.title) return false;
    if (_time != task.time) return false;
    if (done != task.done) return false;
    if (category != task.category) return false;
    return true;
  }

  factory TaskSpec._fromJson(Map<String, dynamic> json) {
    return TaskSpec(
      date: DateTimeFormatter.dateFromString(json[SqfliteKeys.date]),
      done: json[SqfliteKeys.done] == 1,
      time: DateTimeFormatter.timeFromString(json[SqfliteKeys.time]),
      title: json[SqfliteKeys.title],
      description: json[SqfliteKeys.description],
      category: Category.categoryFromJson(json[SqfliteKeys.category]),
    );
  }
}
