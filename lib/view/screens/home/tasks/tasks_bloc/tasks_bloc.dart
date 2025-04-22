import 'dart:developer';

import 'package:ai_assistant_app/domain/models/tasks/category.dart';
import 'package:ai_assistant_app/domain/models/tasks/task.dart';
import 'package:ai_assistant_app/data/services/tasks/tasks_service.dart';
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
          time: TimeOfDay.fromDateTime(event.date),
          title: event.title,
          description: event.description,
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
            time: TimeOfDay.fromDateTime(event.date),
            title: event.title,
            description: event.description,
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
      emit(const TasksLoadingState());

      try {
        log('date when add task in bloc is: ${event.date}');
        log('tasks bloc this event called from : ${event.from}');
        final completedTasks = await _tasksService.getSpecificDayCompletedTasks(
          event.date,
        );
        log('got tasks completed : ${completedTasks.length}');
        log('task bloc testing 0');
        final unCompletedTasks =
            await _tasksService.getSpecificDayUnCompletedTasks(
          event.date,
        );
        log('task bloc testing 1');
        if (unCompletedTasks.isNotEmpty) {
          log('got tasks uncompleted : ${unCompletedTasks.first.taskSpec.date} and number of tasks is : ${unCompletedTasks.length}');
        }

        if ([...completedTasks, ...unCompletedTasks].isEmpty) {
          emit(const GotNoTasksState());
          return;
        }
        log('tasks length is : ${[
          ...completedTasks,
          ...unCompletedTasks
        ].length}');
        emit(GotTasksState(
          completedTasks: completedTasks,
          unCompletedTasks: unCompletedTasks,
        ));
      } catch (e) {
        emit(GotTasksErrorState(e.toString()));
      }
    });

    on<GetTodayTasksEvent>((event, emit) async {
      emit(const TasksLoadingState());
      try {
        log('today tasks event bloc this event called from : ${event.from}');
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
        emit(GotTasksState(
          completedTasks: completedTasks,
          unCompletedTasks: unCompletedTasks,
        ));
      } catch (e) {
        emit(GotTasksErrorState(e.toString()));
      }
    });

    on<GetCategoryTasksEvent>((event, emit) async {
      log('we are in category tasks event');
      emit(const TasksLoadingState());
      try {
        final completedTasks = await _tasksService.getSpecificDayCompletedTasks(
          event.date,
        );
        final catCompletedTasks = _tasksService.getCategoryTasks(
          event.category,
          allTasks: completedTasks,
        );
        final unCompletedTasks =
            await _tasksService.getSpecificDayUnCompletedTasks(
          event.date,
        );

        final catUnCompletedTasks = _tasksService.getCategoryTasks(
          event.category,
          allTasks: unCompletedTasks,
        );
        if ([...catCompletedTasks, ...catUnCompletedTasks].isEmpty) {
          emit(const GotNoTasksState());
          return;
        }
        emit(GotTasksState(
          completedTasks: catCompletedTasks,
          unCompletedTasks: catUnCompletedTasks,
        ));
      } catch (e) {
        emit(GotTasksErrorState(e.toString()));
      }
    });
  }
}
