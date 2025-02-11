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
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      //?here we need to provide the color of the category.
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: CategoryProps.getCategoryColor(
          task.taskSpec.category,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (val) {},
                  ),
                  Text(
                    task.taskSpec.title,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Text(
                '${task.taskSpec.stringDate()}   ${task.taskSpec.stringTime()}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Text(
            task.taskSpec.description,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}
