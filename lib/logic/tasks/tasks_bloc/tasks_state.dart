part of 'tasks_bloc.dart';

sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

final class TasksInitialState extends TasksState {
  const TasksInitialState();
}

final class TasksLoadingState extends TasksState {
  const TasksLoadingState();
}

final class AddedNewTaskState extends TasksState {
  const AddedNewTaskState();
}

final class UpdatedTaskState extends TasksState {
  const UpdatedTaskState();
}

final class DeletedTaskState extends TasksState {
  const DeletedTaskState();
}

final class GotAllTasksState extends TasksState {
  final List<Task> tasks;
  const GotAllTasksState(this.tasks);
  @override
  List<Object> get props => [tasks];
}

final class GotSpecificDayTasksState extends TasksState {
  final List<Task> completedTasks;
  final List<Task> unCompletedTasks;
  const GotSpecificDayTasksState({
    required this.completedTasks,
    required this.unCompletedTasks,
  });
  @override
  List<Object> get props => [completedTasks, unCompletedTasks];
}

final class GotTasksState extends TasksState {
  final List<Task> completedTasks;
  final List<Task> unCompletedTasks;
  const GotTasksState({
    required this.completedTasks,
    required this.unCompletedTasks,
  });
  @override
  List<Object> get props => [completedTasks, unCompletedTasks];
}

final class GotCategoryTasksState extends TasksState {
  final List<Task> completedTasks;
  final List<Task> unCompletedTasks;
  const GotCategoryTasksState({
    required this.completedTasks,
    required this.unCompletedTasks,
  });
  @override
  List<Object> get props => [completedTasks, unCompletedTasks];
}

final class GotCompletedTasksState extends TasksState {
  final List<Task> tasks;
  const GotCompletedTasksState(this.tasks);
  @override
  List<Object> get props => [tasks];
}

final class GotUnCompletedTasksState extends TasksState {
  final List<Task> tasks;
  const GotUnCompletedTasksState(this.tasks);
  @override
  List<Object> get props => [tasks];
}

final class GotNoTasksState extends TasksState {
  const GotNoTasksState();
}

final class GotTasksErrorState extends TasksState {
  final String error;
  const GotTasksErrorState(this.error);
  @override
  List<Object> get props => [error];
}
