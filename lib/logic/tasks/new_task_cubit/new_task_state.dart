part of 'new_task_cubit.dart';

sealed class NewTaskState extends Equatable {
  const NewTaskState();

  @override
  List<Object> get props => [];
}

final class NewTaskInitial extends NewTaskState {
  const NewTaskInitial();
}

final class ValidTaskState extends NewTaskState {
  const ValidTaskState();
}
final class UnValidTaskState extends NewTaskState {
  const UnValidTaskState();
}
