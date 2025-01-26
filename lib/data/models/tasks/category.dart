import 'package:ai_assistant_app/data/key/sqflite_keys.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final class Category {
  final String imagePath;
  final CategoryEnum category;
 final int numberOfTasks;
  Category({
    required this.imagePath,
    required this.category,
    required this.numberOfTasks,
  });

 
  String getCategoryTitle(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    switch (category) {
      case CategoryEnum.education:
        return appLocalizations.education;
      case CategoryEnum.entertainment:
        return appLocalizations.entertainment;
      case CategoryEnum.family:
        return appLocalizations.family;
      case CategoryEnum.work:
        return appLocalizations.work;

      default:
        return appLocalizations.other;
    }
  }
static Color getCategoryColor(CategoryEnum cat) {
    
    switch (cat) {
      case CategoryEnum.education:
        return ColorsManger.educationColor;
      case CategoryEnum.entertainment:
        return ColorsManger.entertainmentColor;
      case CategoryEnum.family:
        return ColorsManger.familyColor;
      case CategoryEnum.work:
        return ColorsManger.workColor;

      default:
        return ColorsManger.otherColor;
    }
  }

  
  static String categoryToJson(CategoryEnum cat) {
    switch (cat) {
      case CategoryEnum.education:
        return SqfliteKeys.education;
      case CategoryEnum.family:
        return SqfliteKeys.family;
      case CategoryEnum.entertainment:
        return SqfliteKeys.entertainment;
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
      case SqfliteKeys.entertainment:
        return CategoryEnum.entertainment;
      case SqfliteKeys.work:
        return CategoryEnum.work;

      default:
        return CategoryEnum.other;
    }
  }
}

enum CategoryEnum {
  education,
  work,
  entertainment,
  family,
  other,
}
