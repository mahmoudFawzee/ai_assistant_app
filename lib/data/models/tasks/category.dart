import 'package:ai_assistant_app/data/key/sqflite_keys.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final class Category {
  final String imagePath;
  final CategoryProps categoryProps;
  final int numberOfTasks;
  Category({
    required this.imagePath,
    required this.numberOfTasks,
    required this.categoryProps,
  });

  static String categoryToJson(CategoryEnum cat) {
    switch (cat) {
      case CategoryEnum.education:
        return SqfliteKeys.education;
      case CategoryEnum.family:
        return SqfliteKeys.family;
      case CategoryEnum.fun:
        return SqfliteKeys.fun;
      case CategoryEnum.work:
        return SqfliteKeys.work;

      default:
        return SqfliteKeys.other;
    }
  }

  static CategoryEnum categoryFromJson(String value) {
    switch (value) {
      case SqfliteKeys.education:
        return CategoryEnum.education;
      case SqfliteKeys.family:
        return CategoryEnum.family;
      case SqfliteKeys.fun:
        return CategoryEnum.fun;
      case SqfliteKeys.work:
        return CategoryEnum.work;
      default:
        return CategoryEnum.other;
    }
  }
}

final class CategoryProps {
  final CategoryEnum category;
  const CategoryProps({required this.category});
  
  String getCategoryTitle(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    switch (category) {
      case CategoryEnum.education:
        return appLocalizations.education;
      case CategoryEnum.fun:
        return appLocalizations.fun;
      case CategoryEnum.family:
        return appLocalizations.family;
      case CategoryEnum.work:
        return appLocalizations.work;
      case CategoryEnum.other:
        return appLocalizations.other;

      default:
        return appLocalizations.all;
    }
  }

  static Color getCategoryColor(CategoryEnum cat) {
    switch (cat) {
      case CategoryEnum.education:
        return ColorsManger.educationColor;
      case CategoryEnum.fun:
        return ColorsManger.funColor;
      case CategoryEnum.family:
        return const Color.fromARGB(255, 129, 240, 199);
      case CategoryEnum.work:
        return ColorsManger.workColor;
      case CategoryEnum.other:
        return ColorsManger.otherColor;

      default:
        return ColorsManger.allColor;
    }
  }
}

enum CategoryEnum {
  all,
  education,
  work,
  fun,
  family,
  other,
}
