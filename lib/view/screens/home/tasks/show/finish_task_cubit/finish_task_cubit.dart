import 'package:ai_assistant_app/domain/models/tasks/task.dart';
import 'package:ai_assistant_app/data/services/tasks/tasks_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
