
import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:ai_assistant_app/data/models/tasks/task.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      //?here we need to provide the color of the category.
      decoration: BoxDecoration(
        color: Category.getCategoryColor(
          task.taskSpec.category,
        ),
      ),
    );
  }
}
