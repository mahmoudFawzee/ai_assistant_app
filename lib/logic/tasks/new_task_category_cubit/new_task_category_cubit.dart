import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTaskCategoryCubit extends Cubit<CategoryProps> {
  NewTaskCategoryCubit()
      : super(const CategoryProps(category: CategoryEnum.all));
  void selectCategory(CategoryProps category) => emit(category);
}
