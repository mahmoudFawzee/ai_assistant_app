import 'dart:developer';

import 'package:ai_assistant_app/data/services/tasks/date_time_formatter.dart'
    as custom_formatter;
import 'package:ai_assistant_app/logic/tasks/category_cubit/category_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/day_decorator_cubit/day_decorator_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/tasks_bloc/tasks_bloc.dart';
import 'package:ai_assistant_app/logic/tasks/welcome_message_cubit/welcome_message_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_assistant_app/view/screens/home/tasks/new_task.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:ai_assistant_app/view/widgets/custom_calender.dart';
import 'package:ai_assistant_app/view/widgets/custom_category.dart';
import 'package:ai_assistant_app/view/widgets/loading_indicator.dart';
import 'package:ai_assistant_app/view/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});
  static const pageRoute = '/todo_screen';

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  DateTime _date = DateTime.now();
  @override
  void initState() {
    super.initState();
    context
        .read<CategoryCubit>()
        .getSpecificDayCategoriesList(_date, 'todo init');
    context
        .read<TasksBloc>()
        .add(GetSpecificDayTasksEvent(_date, from: 'todo init'));
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: BlocBuilder<WelcomeMessageCubit, String>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      '$state Ali',
                      style: const TextStyle(
                        color: ColorsManger.black,
                        fontSize: 24,
                      ),
                    ),
                  );
                },
              ),
            ),

            SliverAppBar(
              pinned: true,
              expandedHeight: 140,
              toolbarHeight: 140,
              flexibleSpace: BlocListener<DayDecoratorCubit, DateTime>(
                listener: (context, state) {
                  log('got date : $state');
                  _date = state;
                },
                child: CustomCalender(
                  onSelectDay: (day) {
                    //?now we have access to the selected day.
                    _date = day.date;
                    context.read<TasksBloc>().add(
                          GetSpecificDayTasksEvent(
                            day.date,
                            from: 'todo page custom calender',
                          ),
                        );
                    context.read<CategoryCubit>().getSpecificDayCategoriesList(
                        day.date, 'custom day page');
                  },
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  appLocalizations.category,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            // //?this is for categories.
            SliverAppBar(
              floating: true,
              expandedHeight: 120,
              toolbarHeight: 120,
              flexibleSpace: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const LoadingIndicator();
                  }
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
                                      _date,
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

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  appLocalizations.tasks,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            //tasks part
            BlocConsumer<TasksBloc, TasksState>(
              listener: (context, state) {
                if (state is DeletedTaskState) {
                  log('todo page data $_date');
                  context.read<CategoryCubit>().getSpecificDayCategoriesList(
                      _date, 'todo page tasks part');
                  context.read<TasksBloc>().add(GetSpecificDayTasksEvent(
                        _date,
                        from: 'deleting listener todo page tasks part',
                      ));
                }
              },
              builder: (context, state) {
                log('todo getting tasks state : $state');
                if (state is TasksLoadingState) {
                  return const SliverToBoxAdapter(child: LoadingIndicator());
                }
                if (state is GotTasksState) {
                  log('todo getting tasks state 2: ${state.unCompletedTasks.length}');
                  final unCompletedTasks = state.unCompletedTasks;
                  final completedTasks = state.completedTasks;
                  final allTasks = [...unCompletedTasks, ...completedTasks];
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        //?here we have uncompleted tasks.
                        final task = allTasks[index];

                        //?here we've completed tasks
                        return TaskCard(task: task);
                      },
                      childCount: allTasks.length,
                    ),
                  );
                }
                if (state is GotNoTasksState) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('no tasks'),
                    ),
                  );
                }
                if (state is GotTasksErrorState) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(state.error),
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final date = custom_formatter.DateTimeFormatter.dateToString(_date);
          context.push('${NewTaskScreen.pageRoute}/${null}/$date');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
