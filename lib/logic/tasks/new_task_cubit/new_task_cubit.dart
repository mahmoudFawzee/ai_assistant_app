import 'dart:developer';

import 'package:ai_assistant_app/data/models/tasks/category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'new_task_state.dart';

class NewTaskCubit extends Cubit<NewTaskState> {
  NewTaskCubit() : super(const NewTaskInitial());
  void validateForm({
    required String? title,
    required String? description,
    required CategoryEnum? category,
    required DateTime? date,
  }) {
    log('enure works start validation');
    emit(const UnValidTaskState());
    if (!_validateTextField(title)) return;
    log('enure works title valid');
    if (!_validateTextField(description)) return;
    log('enure works description valid');
    if (!_validateCategory(category)) return;
    log('enure works category valid');
    if (!_validateDateTime(date)) return;
    log('enure works date valid');
    emit(const ValidTaskState());
  }

  bool _validateTextField(String? value) {
    if (value == null) return false;
    if (value.isEmpty) return false;
    return true;
  }

  bool _validateCategory(CategoryEnum? category) {
    return category != null;
  }

  bool _validateDateTime(DateTime? date) {
    return date != null;
  }
}
