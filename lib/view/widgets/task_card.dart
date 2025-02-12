import 'dart:developer';

import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:ai_assistant_app/data/models/tasks/task.dart';
import 'package:ai_assistant_app/logic/tasks/finish_task_cubit/finish_task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        log('tappd');
      },
      child: Container(
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
                    BlocProvider(
                      create: (context) =>
                          FinishTaskCubit()..init(task.taskSpec.done),
                      child: Builder(builder: (context) {
                        return BlocBuilder<FinishTaskCubit, bool>(
                          builder: (context, state) {
                            return Checkbox(
                              value: state,
                              onChanged: state
                                  ? null
                                  : (val) {
                                      if (val == true) {
                                        context
                                            .read<FinishTaskCubit>()
                                            .finishTask(task);
                                        return;
                                      }
                                    },
                            );
                          },
                        );
                      }),
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
                  '${task.taskSpec.stringDate()}  ${task.taskSpec.stringTime()}',
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
      ),
    );
  }
}
