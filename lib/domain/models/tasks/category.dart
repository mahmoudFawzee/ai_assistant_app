import 'package:ai_assistant_app/data/key/sqflite_keys.dart';
import 'package:ai_assistant_app/view/theme/color_manger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final class Category extends Equatable {
  final CategoryProps categoryProps;
  final int numberOfTasks;
  const Category({
    required this.numberOfTasks,
    required this.categoryProps,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final isPropsEquals =
        other is Category && categoryProps == other.categoryProps;
    final isNumberOfTasksEqual =
        other is Category && numberOfTasks == other.numberOfTasks;
    return isPropsEquals && isNumberOfTasksEqual;
  }

  @override
  int get hashCode => numberOfTasks.hashCode + categoryProps.hashCode;

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

  @override
  List<Object?> get props => [categoryProps, numberOfTasks];
}

final class CategoryProps {
  final CategoryEnum category;
  final String imagePath;
  const CategoryProps({
    required this.category,
    required this.imagePath,
  });

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryProps &&
        category == other.category &&
        imagePath == other.imagePath;
  }

  @override
  int get hashCode => category.hashCode + imagePath.hashCode;


  bool isMatched(CategoryProps? other) {
    if (other == null) return false;
    return category == other.category;
  }
  @override
  String toString() {
    return 'category : $category image : $imagePath';
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
