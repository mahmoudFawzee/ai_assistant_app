part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {
  const CategoryInitial();
}

final class CategoryLoading extends CategoryState {
  const CategoryLoading();
}

final class GotAllCategoriesState extends CategoryState {
  final List<Category> categories;
  const GotAllCategoriesState(this.categories);
  @override
  List<Object> get props => [categories];
}

final class GotCategoriesPropsState extends CategoryState {
  final List<CategoryProps> categoriesProps;
  const GotCategoriesPropsState(this.categoriesProps);
  @override
  List<Object> get props => [categoriesProps];
}
