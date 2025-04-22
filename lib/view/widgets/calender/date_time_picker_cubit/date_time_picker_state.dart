part of 'date_time_picker_cubit.dart';

sealed class DateTimePickerState extends Equatable {
  const DateTimePickerState();

  @override
  List<Object> get props => [];
}

final class DateTimePickerInitial extends DateTimePickerState {
  const DateTimePickerInitial();
}

final class DateTimePickedState extends DateTimePickerState {
  final DateTime pickedDate;
  const DateTimePickedState(this.pickedDate);
  @override
  List<Object> get props => [pickedDate];
}
