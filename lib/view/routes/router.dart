import 'package:ai_assistant_app/domain/models/tasks/task.dart';
import 'package:ai_assistant_app/data/services/tasks/date_time_formatter.dart';
import 'package:ai_assistant_app/view/widgets/calender/date_time_picker_cubit/date_time_picker_cubit.dart';
import 'package:ai_assistant_app/view/widgets/calender/day_decorator_cubit/day_decorator_cubit.dart';
import 'package:ai_assistant_app/view/screens/home/tasks/create/new_task_category_cubit/new_task_category_cubit.dart';
import 'package:ai_assistant_app/view/screens/home/tasks/create/new_task_cubit/new_task_cubit.dart';
import 'package:ai_assistant_app/view/screens/home/weather/weather_bloc/weather_bloc.dart';
import 'package:ai_assistant_app/view/screens/home/base.dart';
import 'package:ai_assistant_app/view/screens/home/ai_assistant/chat/chat_page.dart';
import 'package:ai_assistant_app/view/screens/home/ai_assistant/conversations/conversations_page.dart';
import 'package:ai_assistant_app/view/screens/home/tasks/create/new_task.dart';
import 'package:ai_assistant_app/view/screens/home/tasks/show/todo_page.dart';
import 'package:ai_assistant_app/view/screens/home/weather/weather_page.dart';
import 'package:ai_assistant_app/view/screens/start/on_boarding_screen.dart';
import 'package:ai_assistant_app/view/screens/start/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_assistant_app/view/widgets/calender/calender_cubit/calender_cubit.dart';
import 'package:ai_assistant_app/view/widgets/tasks/category_cubit/category_cubit.dart';
import 'package:ai_assistant_app/view/screens/home/tasks/tasks_bloc/tasks_bloc.dart';
import 'package:ai_assistant_app/app/welcome_message_cubit/welcome_message_cubit.dart';

final _taskBloc = TasksBloc();
final _categoryCubit = CategoryCubit();
final router = GoRouter(
  initialLocation: SplashScreen.pageRoute,
  routes: [
    GoRoute(
      path: SplashScreen.pageRoute,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: OnBoardingScreen.pageRoute,
      builder: (context, state) => const OnBoardingScreen(),
    ),
    GoRoute(
      path: '${ChatScreen.pageRoute}/:conversationId/:conversationTitle',
      builder: (context, state) {
        final conversationId = state.pathParameters['conversationId'];
        final conversationTitle = state.pathParameters['conversationTitle'];
        return ChatScreen(
          conversationId: int.parse(conversationId!),
          conversationTitle: conversationTitle!,
        );
      },
    ),
    GoRoute(
      //?here we will pass each one
      path: '${NewTaskScreen.pageRoute}/:task/:date',
      builder: (context, state) {
        final taskParams = state.pathParameters['task'];

        final Task? task;
        if (taskParams == 'null') {
          task = null;
        } else {
          task = Task.taskFromRouting(taskParams!);
        }
        //?here we need to encode taskParams because we'll decode it later.
        final dateParams = state.pathParameters['date'];

        final DateTime? date;
        if (dateParams == 'null') {
          date = null;
        } else {
          date = DateTimeFormatter.dateFromString(dateParams!);
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => NewTaskCubit(),
            ),
            BlocProvider(
              create: (context) => DateTimePickerCubit(),
            ),
            BlocProvider.value(
              value: _taskBloc,
            ),
            BlocProvider.value(
              value: _categoryCubit,
            ),
            BlocProvider(
              create: (context) => NewTaskCategoryCubit(
                categoryEnum: task?.taskSpec.category,
                imagePath: '',
              ),
            ),
          ],
          child: NewTaskScreen(task: task, date: date),
        );
      },
    ),
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) => BaseScreen(child: child),
      routes: [
        GoRoute(
            path: ConversationsScreen.pageRoute,
            builder: (context, state) {
              return const ConversationsScreen();
            }),
        GoRoute(
            path: ToDoScreen.pageRoute,
            builder: (context, state) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) =>
                        WelcomeMessageCubit()..getWelcomeMessage(context),
                  ),
                  BlocProvider.value(
                    value: _categoryCubit,
                  ),
                  BlocProvider(
                    create: (_) => CalenderCubit()..initCalender(),
                  ),
                  BlocProvider.value(
                    value: _taskBloc,
                  ),
                  BlocProvider(
                    create: (_) =>
                        DayDecoratorCubit()..selectDay(DateTime.now()),
                  ),
                ],
                child: const ToDoScreen(),
              );
            }),
        GoRoute(
            path: WeatherScreen.pageRoute,
            builder: (context, state) {
              return BlocProvider(
                create: (context) =>
                    WeatherBloc()..add(const GetTodayWeatherEvent()),
                child: const WeatherScreen(),
              );
            }),
      ],
    )
  ],
);
