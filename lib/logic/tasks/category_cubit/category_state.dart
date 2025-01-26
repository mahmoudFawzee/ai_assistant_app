part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {
  const CategoryInitial();
}

final class GotAllCategoriesState extends CategoryState {
  final List<Category> categories;
  const GotAllCategoriesState(this.categories);
  @override
  List<Object> get props => [categories];
}
