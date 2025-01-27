import 'package:ai_assistant_app/data/key/sqflite_keys.dart';
import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:ai_assistant_app/data/models/tasks/task.dart';
import 'package:ai_assistant_app/data/services/database_helper.dart';
import 'package:ai_assistant_app/view/resources/images_manger.dart';
import 'package:flutter/material.dart';

final class CategoryService {
  final _databaseHelper = DatabaseHelper();
  Future<List<Category>> getCategoriesList(
    BuildContext context,
  ) async {
    return [
      await _getEducationCategory(),
      await _getFamilyCategory(),
      await _getEntertainmentCategory(),
      await _getWorkCategory(),
      await _getOtherCategory(),
    ];
  }

  Future<int> _getNumberOfTasksPerCategory(CategoryEnum category) async {
    final tasks = await _databaseHelper.getSpecificRows(
      SqfliteKeys.tasksTable,
      where: '${SqfliteKeys.category}=?',
      whereArgs: [Category.categoryToJson(category)],
    );

    return tasks.length;
  }

  List<Task> filterTasks(
    CategoryEnum category, {
    required List<Task> allTasks,
  }) {
    final List<Task> filteredTasks = [];
    for (var element in allTasks) {
      if (element.taskSpec.category == category) {
        filteredTasks.add(element);
      }
    }
    return filteredTasks;
  }

  Future<Category> _getEducationCategory() async => Category(
        imagePath: ImagesManger.educationCategory,
        category: CategoryEnum.education,
        numberOfTasks:
            await _getNumberOfTasksPerCategory(CategoryEnum.education),
      );

  Future<Category> _getFamilyCategory() async => Category(
        imagePath: ImagesManger.familyCategory,
        category: CategoryEnum.family,
        numberOfTasks: await _getNumberOfTasksPerCategory(CategoryEnum.family),
      );
  Future<Category> _getWorkCategory() async => Category(
        imagePath: ImagesManger.workCategory,
        category: CategoryEnum.work,
        numberOfTasks: await _getNumberOfTasksPerCategory(CategoryEnum.work),
      );

  Future<Category> _getEntertainmentCategory() async => Category(
        imagePath: ImagesManger.entertainmentCategory,
        category: CategoryEnum.entertainment,
        numberOfTasks:
            await _getNumberOfTasksPerCategory(CategoryEnum.entertainment),
      );

  Future<Category> _getOtherCategory() async => Category(
        imagePath: ImagesManger.otherCategory,
        category: CategoryEnum.other,
        numberOfTasks: await _getNumberOfTasksPerCategory(CategoryEnum.other),
      );
}
