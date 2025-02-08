import 'dart:developer';

import 'package:ai_assistant_app/data/services/tasks/date_time_formatter.dart';
import 'package:ai_assistant_app/logic/tasks/category_cubit/category_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/day_decorator_cubit/day_decorator_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/tasks_bloc/tasks_bloc.dart';
import 'package:ai_assistant_app/logic/tasks/welcome_message_cubit/welcome_message_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_assistant_app/view/screens/home/new_task.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:ai_assistant_app/view/widgets/custom_calender.dart';
import 'package:ai_assistant_app/view/widgets/custom_category.dart';
import 'package:ai_assistant_app/view/widgets/loading_indicator.dart';
import 'package:ai_assistant_app/view/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});
  static const pageRoute = '/todo_screen';
  static DateTime? _date;
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: BlocBuilder<WelcomeMessageCubit, String>(
              builder: (context, state) {
                return Text(
                  '$state Ali',
                  style: const TextStyle(
                    color: ColorsManger.black,
                    fontSize: 24,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          BlocListener<DayDecoratorCubit, DateTime>(
            listener: (context, state) {
              log('got date : $state');
              _date = state;
            },
            child: const CustomCalender(),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              appLocalizations.category,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          // //?this is for categories.

          SizedBox(
            height: 120,
            child: BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is GotAllCategoriesState) {
                  final cats = state.categories;
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      shrinkWrap: true,
                      itemCount: cats.length,
                      itemBuilder: (context, index) {
                        final category = cats[index];
                        return CustomCategory(
                          category: category,
                          onTap: () {
                            context.read<TasksBloc>().add(
                                  GetCategoryTasksEvent(
                                    category.categoryProps.category,
                                  ),
                                );
                          },
                        );
                      });
                }
                return Container();
              },
            ),
          ),

          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              log('getting tasks state : $state');
              if (state is TasksLoadingState) {
                return const Expanded(child: LoadingIndicator());
              }
              if (state is GotTasksState) {
                final unCompletedTasks = state.unCompletedTasks;
                final completedTasks = state.completedTasks;
                final allTasks = [...unCompletedTasks, ...completedTasks];
                return Expanded(
                  child: ListView.builder(
                    itemCount: allTasks.length,
                    
                    itemBuilder: (context, index) {
                      //?here we have uncompleted tasks.
                      final task = allTasks[index];
                      
                      //?here we've completed tasks
                      return TaskCard(task: task);
                    },
                  ),
                );
              }
              if (state is GotNoTasksState) {
                return const Expanded(
                  child: Center(
                    child: Text('no tasks'),
                  ),
                );
              }
              if (state is GotTasksErrorState) {
                return Expanded(
                  child: Center(
                    child: Text(state.error),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final date = DateTimeFormatter.dateToString(_date ?? DateTime.now());
          context.push(NewTaskScreen.pageRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
