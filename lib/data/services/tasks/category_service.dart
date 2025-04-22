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

   static List<CategoryProps> get categoriesProps => [
    const CategoryProps(
      category: CategoryEnum.education,
      imagePath: ImagesManger.educationCategory,
    ),
    const CategoryProps(
      category: CategoryEnum.family,
      imagePath: ImagesManger.familyCategory,
    ),
    const CategoryProps(
      category: CategoryEnum.fun,
      imagePath: ImagesManger.funCategory,
    ),
    const CategoryProps(
      category: CategoryEnum.work,
      imagePath: ImagesManger.workCategory,
    ),
    const CategoryProps(
      category: CategoryEnum.other,
      imagePath: ImagesManger.otherCategory,
    ),
  ];

 

  int _getNumberOfTasksPerCategory(
    CategoryEnum category, {
    required List<Task> tasks,
  }) {
    if (category == CategoryEnum.all) return tasks.length;
    var nOfTasks = tasks
        .where((element) {
          final picked = element.taskSpec.category == category;

          return picked;
        })
        .toList()
        .length;
    return nOfTasks;
  }

  Future<List<Task>> _getSpecificDayTasks(DateTime? date) async =>
      await _tasksService.getSpecificDayTasks(date ?? DateTime.now());

  static List<Task> filterTasks(
    CategoryEnum category, {
    required List<Task> allTasks,
  }) {
    final List<Task> filteredTasks = [];
    if (category == CategoryEnum.all) return allTasks;
    for (var element in allTasks) {
      if (element.taskSpec.category == category) {
        filteredTasks.add(element);
      }
    }
    return filteredTasks;
  }

  Category _getAllCategory(List<Task> tasks) => Category(
        categoryProps: const CategoryProps(
            category: CategoryEnum.all, imagePath: ImagesManger.allCategories),
        numberOfTasks:
            _getNumberOfTasksPerCategory(CategoryEnum.all, tasks: tasks),
      );

  Category _getEducationCategory(List<Task> tasks) => Category(
        categoryProps: const CategoryProps(
            category: CategoryEnum.education,
            imagePath: ImagesManger.educationCategory),
        numberOfTasks:
            _getNumberOfTasksPerCategory(CategoryEnum.education, tasks: tasks),
      );

  Category _getFamilyCategory(List<Task> tasks) => Category(
        categoryProps: const CategoryProps(
            category: CategoryEnum.family,
            imagePath: ImagesManger.familyCategory),
        numberOfTasks:
            _getNumberOfTasksPerCategory(CategoryEnum.family, tasks: tasks),
      );
  Category _getWorkCategory(List<Task> tasks) => Category(
        categoryProps: const CategoryProps(
            category: CategoryEnum.work, imagePath: ImagesManger.workCategory),
        numberOfTasks:
            _getNumberOfTasksPerCategory(CategoryEnum.work, tasks: tasks),
      );

  Category _getFunCategory(List<Task> tasks) => Category(
        categoryProps: const CategoryProps(
          category: CategoryEnum.fun,
          imagePath: ImagesManger.funCategory,
        ),
        numberOfTasks:
            _getNumberOfTasksPerCategory(CategoryEnum.fun, tasks: tasks),
      );

  Category _getOtherCategory(List<Task> tasks) => Category(
        categoryProps: const CategoryProps(
          category: CategoryEnum.other,
          imagePath: ImagesManger.otherCategory,
        ),
        numberOfTasks:
            _getNumberOfTasksPerCategory(CategoryEnum.other, tasks: tasks),
      );
}
