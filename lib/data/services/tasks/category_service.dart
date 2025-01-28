import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:ai_assistant_app/data/models/tasks/task.dart';
import 'package:ai_assistant_app/data/services/tasks/tasks_service.dart';
import 'package:ai_assistant_app/view/resources/images_manger.dart';

final class CategoryService {
  final _tasksService = TasksService();

  Future<List<Category>> getCategoriesList([DateTime? date]) async {
    return [
      await _getAllCategory(date: date),
      await _getEducationCategory(date: date),
      await _getFamilyCategory(date: date),
      await _getEntertainmentCategory(date: date),
      await _getWorkCategory(date: date),
      await _getOtherCategory(date: date),
    ];
  }

  Future<int> _getNumberOfTasksPerCategory(
    CategoryEnum category, {
    required DateTime? date,
  }) async {
    final tasks = await _getSpecificDayTasks(date);
    return tasks
        .map((element) {
          return element.taskSpec.category == category;
        })
        .toList()
        .length;
  }

  Future<List<Task>> _getSpecificDayTasks(DateTime? date) async =>
      await _tasksService.getSpecificDayTasks(date ?? DateTime.now());
  Future<int> _getSpecificDayNTasks(DateTime? date) async {
    final tasks =
        await _tasksService.getSpecificDayTasks(date ?? DateTime.now());
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

  Future<Category> _getAllCategory({required DateTime? date}) async => Category(
        imagePath: ImagesManger.allCategories,
        category: CategoryEnum.all,
        numberOfTasks: await _getSpecificDayNTasks(date),
      );
  Future<Category> _getEducationCategory({required DateTime? date}) async =>
      Category(
        imagePath: ImagesManger.educationCategory,
        category: CategoryEnum.education,
        numberOfTasks: await _getNumberOfTasksPerCategory(
            CategoryEnum.education,
            date: date),
      );

  Future<Category> _getFamilyCategory({required DateTime? date}) async =>
      Category(
        imagePath: ImagesManger.familyCategory,
        category: CategoryEnum.family,
        numberOfTasks:
            await _getNumberOfTasksPerCategory(CategoryEnum.family, date: date),
      );
  Future<Category> _getWorkCategory({required DateTime? date}) async =>
      Category(
        imagePath: ImagesManger.workCategory,
        category: CategoryEnum.work,
        numberOfTasks:
            await _getNumberOfTasksPerCategory(CategoryEnum.work, date: date),
      );

  Future<Category> _getEntertainmentCategory({required DateTime? date}) async =>
      Category(
        imagePath: ImagesManger.entertainmentCategory,
        category: CategoryEnum.fun,
        numberOfTasks:
            await _getNumberOfTasksPerCategory(CategoryEnum.fun, date: date),
      );

  Future<Category> _getOtherCategory({required DateTime? date}) async =>
      Category(
        imagePath: ImagesManger.otherCategory,
        category: CategoryEnum.other,
        numberOfTasks:
            await _getNumberOfTasksPerCategory(CategoryEnum.other, date: date),
      );
}
