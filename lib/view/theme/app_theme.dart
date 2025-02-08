import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';

ThemeData getTheme(bool? isDark) {
  if (isDark == true) return _darkTheme;
  return _lightTheme;
}

final _lightTheme = ThemeData(
  scaffoldBackgroundColor: ColorsManger.white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ColorsManger.myMessageColor,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: ColorsManger.black,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(ColorsManger.myMessageColor),
      shape: WidgetStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide.none,
        ),
      ),
    ),
  ),
  disabledColor: ColorsManger.myMessageColor.withOpacity(.5),
);

final _darkTheme = ThemeData(
  scaffoldBackgroundColor: ColorsManger.black,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ColorsManger.myMessageColor,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: ColorsManger.white,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(ColorsManger.myMessageColor),
      shape: WidgetStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide.none,
        ),
      ),
    ),
  ),
);
