import 'dart:developer';

import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:ai_assistant_app/data/models/tasks/task.dart';
import 'package:ai_assistant_app/logic/tasks/category_cubit/category_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/date_time_picker_cubit/date_time_picker_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/new_task_category_cubit/new_task_category_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/new_task_cubit/new_task_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/tasks_bloc/tasks_bloc.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:ai_assistant_app/view/widgets/custom_date_time_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({
    super.key,
    required this.task,
    required this.date,
  });
  static const pageRoute = '/new_task_page';
//?we will pass a task as Task?
  //?this task can be null or task
  //?when null? => when we add a new task
  //?when Task? => when we edit an old one.
  final Task? task;
  final DateTime? date;

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  CategoryProps? categoryProps;
  String? title;
  String? description;
  DateTime? date;
  void _validateForm() {
    log('enure works');
    context.read<NewTaskCubit>().validateForm(
          title: title,
          description: description,
          category: categoryProps?.category,
          date: date,
        );
  }

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.taskSpec.title;
      descriptionController.text = widget.task!.taskSpec.description;
    }
    //?directly path the date.
    date = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocListener<TasksBloc, TasksState>(
      listener: (context, state) {
        if (state is AddedNewTaskState) {
          context.read<TasksBloc>().add(GetSpecificDayTasksEvent(widget.date!));
          return;
        }
        if (state is UpdatedTaskState) {
          context.read<TasksBloc>().add(GetSpecificDayTasksEvent(widget.date!));
          return;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManger.white,
          elevation: 0.0,
          title: Text(
            appLocalizations.newTask,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            //?we need title of the task
            TextField(
              controller: titleController,
              minLines: 1,
              maxLines: 2,
              onChanged: (value) {
                title = value;
                _validateForm();
              },
            ),
            //?then we need to add the date and time of it
            BlocBuilder<DateTimePickerCubit, DateTimePickerState>(
              builder: (context, state) {
                if (state is DateTimePickedState) {
                  return CustomDateTimePickerButton(
                    dateTime: state.pickedDate,
                    onDatePicked: () {
                      date = state.pickedDate;
                      _validateForm();
                    },
                  );
                }
                return CustomDateTimePickerButton(
                  dateTime: date,
                  onDatePicked: () {
                      date = date;
                      _validateForm();
                    },
                );
              },
            ),
            //?then we need to add its category
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is GotCategoriesPropsState) {
                  final cats = state.categoriesProps;
                  log('cats num : ${cats.length}');
                  return BlocBuilder<NewTaskCategoryCubit, CategoryProps>(
                    builder: (context, stateCategoryProps) {
                      return DropdownButton<CategoryProps>(
                        value: stateCategoryProps,
                        items: List.generate(
                          cats.length,
                          (index) {
                            final category = cats[index];
                            return DropdownMenuItem<CategoryProps>(
                              onTap: () {
                                categoryProps = category;
                                context
                                    .read<NewTaskCategoryCubit>()
                                    .selectCategory(category);
                                _validateForm();
                              },
                              value: category,
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: CategoryProps.getCategoryColor(
                                    category.category,
                                  ),
                                ),
                                child: Text(
                                  category.getCategoryTitle(
                                    context,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        onChanged: (value) {
                          categoryProps = value;
                        },
                      );
                    },
                  );
                }
                return Container();
              },
            ),
            //?then we need a small description for it (optional)
            TextField(
              controller: descriptionController,
              onChanged: (value) {
                description = value;
                _validateForm();
              },
              minLines: 3,
              maxLines: 5,
            ),
            BlocBuilder<NewTaskCubit, NewTaskState>(
              builder: (context, state) {
                final enabled = state is ValidTaskState;
                log('new task state : $state');
                return ElevatedButton(
                  onPressed: enabled
                      ? () {
                          if (widget.task == null) {
                            context.read<TasksBloc>().add(
                                  AddTaskEvent(
                                    title: title!,
                                    description: description!,
                                    date: date!,
                                    category: categoryProps!.category,
                                  ),
                                );
                            return;
                          }
                          context.read<TasksBloc>().add(
                                UpdateTaskEvent(
                                  oldId: widget.task!.id,
                                  done: widget.task!.taskSpec.done,
                                  title: title!,
                                  description: description!,
                                  date: date!,
                                  category: categoryProps!.category,
                                ),
                              );
                        }
                      : null,
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        backgroundColor: WidgetStateProperty.all(
                          enabled ? Theme.of(context).disabledColor : null,
                        ),
                      ),
                  child: Text(
                    widget.task == null
                        ? appLocalizations.newTask
                        : appLocalizations.editTask,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
