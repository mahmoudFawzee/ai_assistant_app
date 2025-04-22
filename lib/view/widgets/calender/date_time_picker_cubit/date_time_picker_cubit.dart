import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'date_time_picker_state.dart';

class DateTimePickerCubit extends Cubit<DateTimePickerState> {
  DateTimePickerCubit() : super(const DateTimePickerInitial());
  void pickDateTime(DateTime date) => emit(DateTimePickedState(date));
}
