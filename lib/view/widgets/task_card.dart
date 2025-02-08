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
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      //?here we need to provide the color of the category.
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: CategoryProps.getCategoryColor(
          task.taskSpec.category,
        ),
      ),
      child: Center(
        child: Text(
          task.taskSpec.title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
