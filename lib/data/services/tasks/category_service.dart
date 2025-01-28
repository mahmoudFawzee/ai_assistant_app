import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:ai_assistant_app/data/models/tasks/task.dart';
import 'package:ai_assistant_app/data/services/tasks/tasks_service.dart';
import 'package:ai_assistant_app/view/resources/images_manger.dart';

final class CategoryService {
  final _tasksService = TasksService();

  Future<List<Category>> getCategoriesList([DateTime? date]) async {
    final allTasks = await _getSpecificDayTasks(date);
    return [
      _getAllCategory(allTasks),
      _getEducationCategory(allTasks),
      _getFamilyCategory(allTasks),
      _getFunCategory(allTasks),
      _getWorkCategory(allTasks),
      _getOtherCategory(allTasks),
    ];
  }

  List<CategoryProps> getCategoriesSpec() {
    return const [
      CategoryProps(category: CategoryEnum.all),
      CategoryProps(category: CategoryEnum.education),
      CategoryProps(category: CategoryEnum.family),
      CategoryProps(category: CategoryEnum.fun),
      CategoryProps(category: CategoryEnum.work),
      CategoryProps(category: CategoryEnum.other),
    ];
  }

  int _getNumberOfTasksPerCategory(
    CategoryEnum category, {
    required List<Task> tasks,
  }) {
    if (category == CategoryEnum.all) return tasks.length;
    return tasks
        .map((element) {
          return element.taskSpec.category == category;
        })
        .toList()
        .length;
  }

  Future<List<Task>> _getSpecificDayTasks(DateTime? date) async =>
      await _tasksService.getSpecificDayTasks(date ?? DateTime.now());

  static List<Task> filterTasks(
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

  Category _getAllCategory(List<Task> tasks) => Category(
        imagePath: ImagesManger.allCategories,
        categoryProps: const CategoryProps(category: CategoryEnum.all),
        numberOfTasks:
            _getNumberOfTasksPerCategory(CategoryEnum.all, tasks: tasks),
      );

  Category _getEducationCategory(List<Task> tasks) => Category(
        imagePath: ImagesManger.educationCategory,
        categoryProps: const CategoryProps(category: CategoryEnum.education),
        numberOfTasks:
            _getNumberOfTasksPerCategory(CategoryEnum.education, tasks: tasks),
      );
  Category _getFamilyCategory(List<Task> tasks) => Category(
        imagePath: ImagesManger.familyCategory,
        categoryProps: const CategoryProps(category: CategoryEnum.family),
        numberOfTasks:
            _getNumberOfTasksPerCategory(CategoryEnum.family, tasks: tasks),
      );
  Category _getWorkCategory(List<Task> tasks) => Category(
        imagePath: ImagesManger.workCategory,
        categoryProps: const CategoryProps(category: CategoryEnum.work),
        numberOfTasks:
            _getNumberOfTasksPerCategory(CategoryEnum.work, tasks: tasks),
      );

  Category _getFunCategory(List<Task> tasks) => Category(
        imagePath: ImagesManger.funCategory,
        categoryProps: const CategoryProps(category: CategoryEnum.fun),
        numberOfTasks:
            _getNumberOfTasksPerCategory(CategoryEnum.fun, tasks: tasks),
      );

  Category _getOtherCategory(List<Task> tasks) => Category(
        imagePath: ImagesManger.otherCategory,
        categoryProps: const CategoryProps(category: CategoryEnum.other),
        numberOfTasks:
            _getNumberOfTasksPerCategory(CategoryEnum.other, tasks: tasks),
      );
}
