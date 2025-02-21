import 'dart:developer';

import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:ai_assistant_app/data/models/tasks/task.dart';
import 'package:ai_assistant_app/logic/tasks/category_cubit/category_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/date_time_picker_cubit/date_time_picker_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/new_task_category_cubit/new_task_category_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/new_task_cubit/new_task_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/tasks_bloc/tasks_bloc.dart';
import 'package:ai_assistant_app/view/widgets/custom_text_field.dart';
import 'package:go_router/go_router.dart';
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
  //?in task we will need just id and date and time and title and decoration and category
  //?we will pass them directly through the route
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
    //?directly path the date.
    date = widget.date;
    context.read<DateTimePickerCubit>().pickDateTime(date!);
    if (widget.task != null) {
      title = widget.task!.taskSpec.title;
      titleController.text = title!;
      description = widget.task!.taskSpec.description;
      descriptionController.text = description!;
      categoryProps = CategoryProps(category: widget.task!.taskSpec.category);
    }
    _validateForm();
  }

  void closePage() {
    context.read<TasksBloc>().add(GetSpecificDayTasksEvent(widget.date!));
    context.read<CategoryCubit>().getSpecificDayCategoriesList(widget.date!);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final mediaQuery = MediaQuery.of(context).size;
    return BlocListener<TasksBloc, TasksState>(
      listener: (context, state) {
        if (state is AddedNewTaskState) {
          closePage();
          return;
        }
        if (state is UpdatedTaskState) {
          closePage();
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //?we need title of the task
                CustomTextField(
                  controller: titleController,
                  hint: appLocalizations.title,
                  minLines: 1,
                  maxLines: 2,
                  onChanged: (value) {
                    title = value;
                    _validateForm();
                  },
                ),

                const SizedBox(height: 40),

                //?then we need to add the date and time of it

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BlocBuilder<CategoryCubit, CategoryState>(
                      buildWhen: (previous, current) {
                        if (current is GotAllCategoriesState &&
                            previous is GotCategoriesPropsState) {
                          return false;
                        }
                        return true;
                      },
                      builder: (context, state) {
                        if (state is GotCategoriesPropsState) {
                          final cats = state.categoriesProps.sublist(1);
                          log('cats : $cats');
                          return BlocConsumer<NewTaskCategoryCubit,
                              CategoryProps?>(
                            listener: (context, state) {
                              categoryProps = state;
                            },
                            builder: (context, stateCategoryProps) {
                              //!the problem happens because we need to override == operator
                              //!and hashCode methods in the class to tell dart
                              //!when does the class CategoryProps objects are equals.
                              return DropdownButton<CategoryProps>(
                                menuWidth: mediaQuery.width / 3,
                                value: categoryProps,
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
                                        alignment: Alignment.center,
                                        width: mediaQuery.width / 3,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
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
                    //?then we need to add its category
                    BlocConsumer<DateTimePickerCubit, DateTimePickerState>(
                      listener: (context, state) {
                        if (state is DateTimePickedState) {
                          date = state.pickedDate;
                          return;
                        }
                      },
                      builder: (context, state) {
                        log('date state : $state');
                        if (state is DateTimePickedState) {
                          return CustomDateTimePickerButton(
                            dateTime: state.pickedDate,
                            onDatePicked: () => _validateForm(),
                          );
                        }
                        return CustomDateTimePickerButton(
                          dateTime: date,
                          onDatePicked: () => _validateForm(),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                //?then we need a small description for it (optional)
                CustomTextField(
                  controller: descriptionController,
                  hint: appLocalizations.description,
                  onChanged: (value) {
                    description = value;
                    _validateForm();
                  },
                  minLines: 3,
                  maxLines: 5,
                ),
                const SizedBox(height: 50),

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
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style!
                          .copyWith(
                            minimumSize: WidgetStateProperty.all(
                                Size(mediaQuery.width / 1.5, 50)),
                            backgroundColor: WidgetStateProperty.all(
                              enabled ? null : Theme.of(context).disabledColor,
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
        ),
      ),
    );
  }
}
