import 'package:ai_assistant_app/logic/local/name_cubit/name_cubit.dart';
import 'package:ai_assistant_app/logic/local/navigation_cubit/navigation_cubit.dart';
import 'package:ai_assistant_app/logic/local/them_cubit/theme_cubit.dart';
import 'package:ai_assistant_app/view/routes/router.dart';
import 'package:ai_assistant_app/view/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit()..getTheme(),
        ),
        BlocProvider(
          create: (context) => NameCubit()..getName(),
        ),
        BlocProvider(
          create: (context) => NavigationCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, bool?>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: getTheme(state),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
