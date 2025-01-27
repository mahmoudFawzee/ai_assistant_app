import 'dart:developer';
import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:ai_assistant_app/logic/tasks/category_cubit/category_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/tasks_bloc/tasks_bloc.dart';
import 'package:ai_assistant_app/logic/tasks/welcome_message_cubit/welcome_message_cubit.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:ai_assistant_app/view/widgets/custom_calender.dart';
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
          const CustomCalender(),
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
                                    category.category,
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

class CustomCategory extends StatelessWidget {
  const CustomCategory({
    super.key,
    required this.category,
    required this.onTap,
  });

  final Category category;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Category.getCategoryColor(
          category.category,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        shape: BoxShape.rectangle,
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                height: 30,
                width: 30,
                category.imagePath,
                color: ColorsManger.white,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              maxLines: 2,
              textAlign: TextAlign.start,
              text: TextSpan(
                style: const TextStyle(
                  color: ColorsManger.white,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: '${category.getCategoryTitle(context)}\n',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const WidgetSpan(child: SizedBox(height: 20)),
                  TextSpan(text: '${category.numberOfTasks}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
