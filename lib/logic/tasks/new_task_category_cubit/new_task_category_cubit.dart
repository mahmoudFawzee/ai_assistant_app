import 'dart:developer';

import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTaskCategoryCubit extends Cubit<CategoryProps> {
  static CategoryProps _initialCategory(CategoryEnum? categoryEnum) {
    if (categoryEnum == null) {
      return const CategoryProps(category: CategoryEnum.all);
    }
    return CategoryProps(category: categoryEnum);
  }

  NewTaskCategoryCubit({required CategoryEnum? categoryEnum})
      : super(_initialCategory(categoryEnum));
  void selectCategory(CategoryProps category) {
    log('emit : $category');
    emit(category);
  }
}
