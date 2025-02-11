import 'package:ai_assistant_app/data/models/tasks/task.dart';
import 'package:ai_assistant_app/data/services/tasks/tasks_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'finish_task_state.dart';

class FinishTaskCubit extends Cubit<bool> {
  FinishTaskCubit() : super(false);
  final _tasksService = TasksService();
  init(bool isFinished) => emit(isFinished);
  void finishTask(
     Task task,
  ) async {
    try {
      await _tasksService.updateTask(Task.confirmTaskFinished(task));
      emit(true);
    } catch (e) {
      emit(false);
    }
  }
}
