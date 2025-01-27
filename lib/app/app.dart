import 'package:ai_assistant_app/logic/chat/conversation_cubit/conversation_cubit.dart';
import 'package:ai_assistant_app/logic/chat/messages_bloc/messages_bloc.dart';
import 'package:ai_assistant_app/logic/local/localization_cubit/localization_cubit.dart';
import 'package:ai_assistant_app/logic/local/name_cubit/name_cubit.dart';
import 'package:ai_assistant_app/logic/local/navigation_cubit/navigation_cubit.dart';
import 'package:ai_assistant_app/logic/local/them_cubit/theme_cubit.dart';
import 'package:ai_assistant_app/logic/weather/weather_bloc/weather_bloc.dart';
import 'package:ai_assistant_app/view/routes/router.dart';
import 'package:ai_assistant_app/view/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        BlocProvider(
          create: (context) => LocalizationCubit()..getLang(),
        ),
        BlocProvider(
          create: (context) => ConversationCubit()..getConversations(),
        ),
        BlocProvider(
          create: (context) => MessagesBloc(),
        ),
        BlocProvider(
          create: (context) => WeatherBloc()..add(const GetTodayWeatherEvent()),
        ),
      
      ],
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, langState) {
          String? lang;
          if (langState is GotLangState) {
            lang = langState.langCode;
          } else if (langState is LangChangedState) {
            lang = langState.langCode;
          }
          return BlocBuilder<ThemeCubit, bool?>(
            builder: (context, themeState) {
              return MaterialApp.router(
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  AppLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'), // English
                  Locale('ar'), // arabic
                ],
                locale: Locale(lang ?? 'en'),
                debugShowCheckedModeBanner: false,
                theme: getTheme(themeState),
                routerConfig: router,
              );
            },
          );
        },
      ),
    );
  }
}
