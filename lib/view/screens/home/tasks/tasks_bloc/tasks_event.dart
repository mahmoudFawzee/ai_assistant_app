part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

final class GetUnCompletedTasksEvent extends TasksEvent {
  const GetUnCompletedTasksEvent();

  @override
  List<Object> get props => [];
}

final class GetCompletedTasksEvent extends TasksEvent {
  const GetCompletedTasksEvent();
}

final class GetTodayTasksEvent extends TasksEvent {
  final String from;
  const GetTodayTasksEvent(this.from);
}

final class GetAllTasksEvent extends TasksEvent {
  const GetAllTasksEvent();

  @override
  List<Object> get props => [];
}

final class GetSpecificDayTasksEvent extends TasksEvent {
  final DateTime date;
  final String from;
  const GetSpecificDayTasksEvent(this.date, {required this.from});

  @override
  List<Object> get props => [date];
}

final class GetCategoryTasksEvent extends TasksEvent {
  final CategoryEnum category;
  final DateTime date;
  const GetCategoryTasksEvent(this.category, this.date);

  @override
  List<Object> get props => [category, date];
}

final class AddTaskEvent extends TasksEvent {
  final String title;
  final String description;
  final DateTime date;
  final CategoryEnum category;
  const AddTaskEvent({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });
  @override
  List<Object> get props => [date, category, title, description];
}

final class UpdateTaskEvent extends TasksEvent {
  final int oldId;
  final String title;
  final String description;
  final bool done;
  final DateTime date;
  final CategoryEnum category;
  const UpdateTaskEvent({
    required this.oldId,
    required this.title,
    required this.description,
    required this.done,
    required this.date,
    required this.category,
  });
  @override
  List<Object> get props => [oldId, done, date, category, title, description];
}

final class DeleteTaskEvent extends TasksEvent {
  final int id;
  const DeleteTaskEvent(this.id);
  @override
  List<Object> get props => [id];
}
