import 'dart:developer';

import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:ai_assistant_app/data/services/tasks/category_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(const CategoryInitial());
  final _categoryService = CategoryService();

  void getSpecificDayCategoriesList(DateTime date) async {
    log('get cats now 2');
    final categories = await _categoryService.getCategoriesList(date);
    log('get cats now updated : $categories');
    emit(GotAllCategoriesState(categories));
  }

  void getCategoriesNamesAndColors() async {
    final categoriesProps = _categoryService.getCategoriesSpec();
    emit(GotCategoriesPropsState(categoriesProps));
  }
}
