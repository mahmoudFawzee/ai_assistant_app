part of 'calender_cubit.dart';

sealed class CalenderState extends Equatable {
  const CalenderState();

  @override
  List<Object?> get props => [];
}

final class CalenderInitialState extends CalenderState {
  const CalenderInitialState();
}

final class GotWeekState extends CalenderState {
  final Week week;
  const GotWeekState({required this.week});
  @override
  List<Object?> get props => [week];
}

final class GotNextMonthState extends CalenderState {
  final Week week;
  const GotNextMonthState({required this.week});
  @override
  List<Object?> get props => [week];
}

final class GotNextYearState extends CalenderState {
  final Week week;
  const GotNextYearState({required this.week});
  @override
  List<Object?> get props => [week];
}
