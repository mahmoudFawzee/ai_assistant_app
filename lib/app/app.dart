import 'package:ai_assistant_app/logic/name_cubit/name_cubit.dart';
import 'package:ai_assistant_app/logic/them_cubit/theme_cubit.dart';
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
<<<<<<< HEAD
          create: (context) => ThemeCubit()..changeTheme(),
=======
          create: (context) => ThemeCubit()..getTheme(),
>>>>>>> b54be31 (work on ui)
        ),
        BlocProvider(
          create: (context) => NameCubit()..getName(),
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
