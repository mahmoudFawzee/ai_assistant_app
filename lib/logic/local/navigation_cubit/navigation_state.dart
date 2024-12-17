part of 'navigation_cubit.dart';

sealed class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

final class NavigationInitial extends NavigationState {

  final int index;
  const NavigationInitial({required this.index});
  @override
  List<Object> get props => [ index];
}
final class MovedToPageState extends NavigationState {
  final int index;
  const MovedToPageState({required this.index});
  @override
  List<Object> get props => [ index];
}
