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
  const GetTodayTasksEvent();
}

final class GetAllTasksEvent extends TasksEvent {
  const GetAllTasksEvent();

  @override
  List<Object> get props => [];
}

final class GetSpecificDayTasksEvent extends TasksEvent {
  final DateTime date;
  const GetSpecificDayTasksEvent(this.date);

  @override
  List<Object> get props => [date];
}

final class GetCategoryTasksEvent extends TasksEvent {
  final CategoryEnum category;
  const GetCategoryTasksEvent(this.category);

  @override
  List<Object> get props => [category];
}

final class AddTaskEvent extends TasksEvent {
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final CategoryEnum category;
  const AddTaskEvent({
    required this.title,
    required this.description,
    required this.time,
    required this.date,
    required this.category,
  });
  @override
  List<Object> get props => [date, time, category, title,description];
}

final class UpdateTaskEvent extends TasksEvent {
  final int oldId;
  final String title;
  final String description;
  final bool done;
  final DateTime date;

  final TimeOfDay time;
  final Category category;
  const UpdateTaskEvent({
    required this.oldId,
    required this.title,
    required this.description,
    required this.done,
    required this.time,
    required this.date,
    required this.category,
  });
  @override
  List<Object> get props => [oldId, done, date, time, category, title,description];
}

final class DeleteTaskEvent extends TasksEvent {
  final int id;
  const DeleteTaskEvent(this.id);
  @override
  List<Object> get props => [id];
}
