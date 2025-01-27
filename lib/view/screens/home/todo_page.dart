import 'dart:developer';
import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:ai_assistant_app/logic/tasks/category_cubit/category_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/tasks_bloc/tasks_bloc.dart';
import 'package:ai_assistant_app/logic/tasks/welcome_message_cubit/welcome_message_cubit.dart';
import 'package:ai_assistant_app/view/widgets/custom_calender.dart';
import 'package:ai_assistant_app/view/widgets/loading_indicator.dart';
import 'package:ai_assistant_app/view/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});
  static const pageRoute = '/todo_screen';

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          // BlocBuilder<WelcomeMessageCubit, String>(
          //   builder: (context, state) {
          //     return Text(
          //       '$state Ali',
          //     );
          //   },
          // ),

          const CustomCalender(),
          Text(
            appLocalizations.category,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          // //?this is for categories.
          
          SizedBox(
            height: 75,
            child: BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is GotAllCategoriesState) {
                  final cats = state.categories;
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      cats.length,
                      (index) {
                        final category = cats[index];
                        log('the category is : $category');
                        return InkWell(
                          onTap: () {
                            context.read<TasksBloc>().add(
                                  GetCategoryTasksEvent(
                                    category.category,
                                  ),
                                );
                          },
                          child: Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              color: Category.getCategoryColor(
                                category.category,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
          
          // BlocBuilder<TasksBloc, TasksState>(
          //   builder: (context, state) {
          //     if (state is TasksLoadingState) {
          //       return const LoadingIndicator();
          //     }
          //     if (state is GotTasksState) {
          //       final unCompletedTasks = state.unCompletedTasks;
          //       final completedTasks = state.completedTasks;
          //       final allTasks = [...unCompletedTasks, ...completedTasks];
          //       return ListView.builder(
          //         itemBuilder: (context, index) {
          //           //?here we have uncompleted tasks.
          //           final task = allTasks[index];
          //           if (index < unCompletedTasks.length) {
          //             return TaskCard(task: task);
          //           }
          //           //?here we've completed tasks
          //           return TaskCard(task: task);
          //         },
          //       );
          //     }
          //     return Container();
          //   },
          // ),
        
        
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
