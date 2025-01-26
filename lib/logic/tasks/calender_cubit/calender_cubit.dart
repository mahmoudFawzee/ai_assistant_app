import 'package:ai_assistant_app/data/models/tasks/day_per_week.dart';
import 'package:ai_assistant_app/data/services/tasks/calender_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'calender_state.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CalenderCubit() : super(const CalenderInitialState());
  final _calenderService = CalenderService();
  DateTime? currentDate;
  void initCalender() {
    final todayDate = DateTime.now();
    currentDate = todayDate;
    final week = _calenderService.getWeek(todayDate);
    emit(GotWeekState(week: week));
  }

  void nextWeek() => _moveWeek(moveForward: true);
  void preWeek() => _moveWeek(moveForward: false);
  void nextMonth() => _moveMonth(moveForward: true);
  void preMonth() => _moveMonth(moveForward: false);
  void nextYear() => _moveYear(moveForward: true);
  void preYear() => _moveYear(moveForward: false);

  void _moveWeek({required bool moveForward}) {
    //?where are we and where we are going to.
    //? we are in current year and month and week.
    //? and we move to next week (move 7 days.)
    int movementAmount = moveForward ? 7 : -7;
    final movementDays = currentDate!.day + movementAmount;
    final date = currentDate!.subtract(Duration(days: movementDays));
    final week = _calenderService.getWeek(date);
    emit(GotWeekState(week: week));
  }

  void _moveMonth({required bool moveForward}) {
    int movementAmount = moveForward ? 1 : -1;
    final monthDays = _calenderService.getMonthDays(
      year: currentDate!.year,
      month: currentDate!.month + movementAmount,
    );
    final date = currentDate!.subtract(Duration(days: monthDays));
    final week = _calenderService.getWeek(date);
    emit(GotWeekState(week: week));
  }

  void _moveYear({required bool moveForward}) {
    int movementAmount = moveForward ? 1 : -1;
    final isLeapYear = _calenderService.isLeapYear(
      currentDate!.year + movementAmount,
    );
    final date = currentDate!.subtract(Duration(days: isLeapYear ? 366 : 365));
    final week = _calenderService.getWeek(date);
    emit(GotWeekState(week: week));
  }
}
