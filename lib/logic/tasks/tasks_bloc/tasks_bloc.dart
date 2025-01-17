import 'package:ai_assistant_app/data/models/task.dart';
import 'package:ai_assistant_app/data/services/tasks_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final _tasksService = TasksService();
  TasksBloc() : super(const TasksInitialState()) {
    on<AddTaskEvent>((event, emit) async {
      try {
        final TaskSpec taskSpec = TaskSpec(
          date: event.date,
          done: false,
          time: event.time,
          title: event.title,
          category: event.category,
        );
        await _tasksService.addTask(taskSpec);
        emit(const AddedNewTaskState());
      } catch (e) {
        emit(GotTasksErrorState(e.toString()));
      }
    });

    on<UpdateTaskEvent>((event, emit) async {
      try {
        final task = Task(
          id: event.oldId,
          taskSpec: TaskSpec(
            date: event.date,
            done: event.done,
            time: event.time,
            title: event.title,
            category: event.category,
          ),
        );
        await _tasksService.updateTask(task);
        emit(const UpdatedTaskState());
      } catch (e) {
        emit(GotTasksErrorState(e.toString()));
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      try {
        await _tasksService.deleteTask(event.id);
        emit(const DeletedTaskState());
      } catch (e) {
        emit(GotTasksErrorState(e.toString()));
      }
    });

    on<GetSpecificDayTasksEvent>((event, emit) async {
      try {
        final completedTasks = await _tasksService.getSpecificDayCompletedTasks(
          event.date,
        );
        final unCompletedTasks =
            await _tasksService.getSpecificDayUnCompletedTasks(
          event.date,
        );
        if ([...completedTasks, ...unCompletedTasks].isEmpty) {
          emit(const GotNoTasksState());
          return;
        }
        emit(GotSpecificDayTasksState(
          completedTasks: completedTasks,
          unCompletedTasks: unCompletedTasks,
        ));
      } catch (e) {
        emit(GotTasksErrorState(e.toString()));
      }
    });
    
    on<GetTodayTasksEvent>((event, emit) async {
      try {
        final completedTasks = await _tasksService.getSpecificDayCompletedTasks(
          DateTime.now(),
        );
        final unCompletedTasks =
            await _tasksService.getSpecificDayUnCompletedTasks(
          DateTime.now(),
        );
        if ([...completedTasks, ...unCompletedTasks].isEmpty) {
          emit(const GotNoTasksState());
          return;
        }
        emit(GotSpecificDayTasksState(
          completedTasks: completedTasks,
          unCompletedTasks: unCompletedTasks,
        ));
      } catch (e) {
        emit(GotTasksErrorState(e.toString()));
      }
    });
  }
}
