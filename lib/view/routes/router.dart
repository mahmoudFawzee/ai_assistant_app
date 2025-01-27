import 'package:ai_assistant_app/view/screens/home/base.dart';
import 'package:ai_assistant_app/view/screens/home/chat_page.dart';
import 'package:ai_assistant_app/view/screens/home/conversations_page.dart';
import 'package:ai_assistant_app/view/screens/home/todo_page.dart';
import 'package:ai_assistant_app/view/screens/home/weather_page.dart';
import 'package:ai_assistant_app/view/screens/start/on_boarding_screen.dart';
import 'package:ai_assistant_app/view/screens/start/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_assistant_app/logic/tasks/calender_cubit/calender_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/category_cubit/category_cubit.dart';
import 'package:ai_assistant_app/logic/tasks/tasks_bloc/tasks_bloc.dart';
import 'package:ai_assistant_app/logic/tasks/welcome_message_cubit/welcome_message_cubit.dart';

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
      path: '${ChatScreen.pageRoute}/:conversationId',
      builder: (context, state) {
        final conversationId = state.pathParameters['conversationId'];
        return ChatScreen(conversationId: int.parse(conversationId!));
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
                    create: (context) =>
                        WelcomeMessageCubit()..getWelcomeMessage(context),
                  ),
                  BlocProvider(
                    create: (context) =>
                        CategoryCubit()..getCategories(context),
                  ),
                  BlocProvider(
                    create: (context) => CalenderCubit()..initCalender(),
                  ),
                  BlocProvider(
                    create: (context) =>
                        TasksBloc()..add(const GetTodayTasksEvent()),
                  ),
                ],
                child: const ToDoScreen(),
              );
            }),
        GoRoute(
            path: WeatherScreen.pageRoute,
            builder: (context, state) {
              return const WeatherScreen();
            }),
      ],
    )
  ],
);
