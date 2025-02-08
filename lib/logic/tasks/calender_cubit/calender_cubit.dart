import 'dart:developer';

import 'package:ai_assistant_app/data/models/tasks/week.dart';
import 'package:ai_assistant_app/data/services/tasks/calender_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'calender_state.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CalenderCubit() : super(const CalenderInitialState());
  final _calenderService = CalenderService();
  DateTime? _currentDate;
  void initCalender() {
    log('start calender');
    final todayDate = DateTime.now();
    _currentDate = todayDate;
    final week = _calenderService.getWeek(todayDate);
    log('we got week : $week');
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

    final date = getWantedDate(
      baseDate: _currentDate!,
      days: 7,
      forward: moveForward,
    );
    log('new date : $date');
    _currentDate = date;
    final week = _calenderService.getWeek(_currentDate!);
    emit(GotWeekState(week: week));
  }

  void _moveMonth({required bool moveForward}) {
    final monthDays = _calenderService.getMonthDays(
      year: _currentDate!.year,
      month: _currentDate!.month,
    );
    final date = getWantedDate(
      baseDate: _currentDate!,
      days: monthDays,
      forward: moveForward,
    );
    log('new date : $date and days : $monthDays');
    _currentDate = date;
    final week = _calenderService.getWeek(_currentDate!);
    emit(GotWeekState(week: week));
  }

  void _moveYear({required bool moveForward}) {
    int movementAmount = moveForward ? 1 : -1;
    final isLeapYear = _calenderService.isLeapYear(
      _currentDate!.year + movementAmount,
    );
    final date = _currentDate!.subtract(Duration(days: isLeapYear ? 366 : 365));
    final week = _calenderService.getWeek(date);
    emit(GotWeekState(week: week));
  }

  DateTime getWantedDate({
    required DateTime baseDate,
    required int days,
    required bool forward,
  }) {
    if (forward) {
      return baseDate.add(Duration(days: days));
    }
    return baseDate.subtract(Duration(days: days));
  }
}
