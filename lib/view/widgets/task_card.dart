import 'dart:developer';
import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:ai_assistant_app/data/models/tasks/task.dart';
import 'package:ai_assistant_app/logic/tasks/category_cubit/category_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/finish_task_cubit/finish_task_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/tasks_bloc/tasks_bloc.dart';
import 'package:ai_assistant_app/view/screens/home/tasks/new_task.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              task.taskSpec.description,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 8,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 5),
              const Divider(
                color: ColorsManger.grey,
                thickness: 1,
                height: 0,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskCardButton(
                      label: appLocalizations.edit,
                      onPressed: () {
                        context.push(
                            '${NewTaskScreen.pageRoute}/${task.taskToRouting()}/${task.taskSpec.date}');
                      },
                    ),
                    const VerticalDivider(
                      color: ColorsManger.grey,
                      thickness: 1,
                      width: 0,
                      indent: 0,
                      endIndent: 0,
                    ),
                    TaskCardButton(
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.warning,
                          title: appLocalizations.deleteTask,
                          btnCancelOnPress: () {
                            log('cancel');
                          },
                          btnOkOnPress: () {
                            context
                                .read<TasksBloc>()
                                .add(DeleteTaskEvent(task.id));
                            // context.read<CategoryCubit>().getSpecificDayCategoriesList(task.taskSpec.date);
                            // context
                            //     .read<TasksBloc>()
                            //     .add(GetSpecificDayTasksEvent(
                            //       task.taskSpec.date,
                            //     ));
                          },
                        ).show();
                      },
                      label: appLocalizations.delete,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TaskCardButton extends StatelessWidget {
  const TaskCardButton({
    super.key,
    required this.label,
    required this.onPressed,
  });
  final String label;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(ColorsManger.black),
          padding: WidgetStateProperty.all(
            const EdgeInsets.all(0),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
