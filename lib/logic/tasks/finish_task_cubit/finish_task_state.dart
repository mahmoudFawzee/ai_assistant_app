part of 'finish_task_cubit.dart';

sealed class FinishTaskState extends Equatable {
  const FinishTaskState();

  @override
  List<Object> get props => [];
}

final class FinishTaskInitialState extends FinishTaskState {
  const FinishTaskInitialState();
}

final class TaskFinishLoadingState extends FinishTaskState {
  const TaskFinishLoadingState();
}

final class TaskFinishedState extends FinishTaskState {
  const TaskFinishedState();
}


final class TaskFinishedErrorState extends FinishTaskState {
  const TaskFinishedErrorState();
}
