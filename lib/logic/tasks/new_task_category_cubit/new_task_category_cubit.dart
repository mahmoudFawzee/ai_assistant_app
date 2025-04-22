import 'dart:developer';

import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:ai_assistant_app/view/resources/images_manger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTaskCategoryCubit extends Cubit<CategoryProps> {
  static CategoryProps _initialCategory({
    required CategoryEnum? categoryEnum,
    required String imagePath,
  }) {
    if (categoryEnum == null) {
      return const CategoryProps(
        category: CategoryEnum.all,
        imagePath: ImagesManger.allCategories,
      );
    }
    return CategoryProps(category: categoryEnum, imagePath: imagePath);
  }

  NewTaskCategoryCubit({
    required CategoryEnum? categoryEnum,
    required String imagePath,
  }) : super(
          _initialCategory(
            categoryEnum: categoryEnum,
            imagePath: imagePath,
          ),
        );
  void selectCategory(CategoryProps category) {
    log('emit : $category');
    emit(category);
  }
}
