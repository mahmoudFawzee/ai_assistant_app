import 'package:ai_assistant_app/view/screens/home/base.dart';
import 'package:ai_assistant_app/view/screens/home/chat_page.dart';
<<<<<<< HEAD
=======
import 'package:ai_assistant_app/view/screens/home/conversations_page.dart';
>>>>>>> b54be31 (work on ui)
import 'package:ai_assistant_app/view/screens/home/todo_page.dart';
import 'package:ai_assistant_app/view/screens/home/weather_page.dart';
import 'package:ai_assistant_app/view/screens/start/on_boarding_screen.dart';
import 'package:ai_assistant_app/view/screens/start/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
<<<<<<< HEAD
=======
    GoRoute(
      path: ChatScreen.pageRoute,
      builder: (context, state) => const ChatScreen(),
    ),
>>>>>>> b54be31 (work on ui)
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) => BaseScreen(child: child),
      routes: [
        GoRoute(
<<<<<<< HEAD
            path: ChatScreen.pageRoute,
            builder: (context, state) {
              return const ChatScreen();
=======
            path: ConversationsScreen.pageRoute,
            builder: (context, state) {
              return const ConversationsScreen();
>>>>>>> b54be31 (work on ui)
            }),
        GoRoute(
            path: ToDoScreen.pageRoute,
            builder: (context, state) {
              return const ToDoScreen();
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
