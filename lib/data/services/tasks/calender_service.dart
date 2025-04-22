import 'package:ai_assistant_app/domain/models/tasks/week.dart';

final class CalenderService {
  int getMonthDays({
    required int year,
    required int month,
  }) {
    if (month > 12) month = 1;
    if (month < 1) month = 12;
    switch (month) {
      case 4 || 6 || 9 || 11:
        return 30;
      case 2:
        return _handleFebruary(year);
      default:
        return 31;
    }
  }

  bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  int _handleFebruary(int year) {
    if (isLeapYear(year)) return 29;
    return 28;
  }

  Week getWeek(DateTime date) {
    // Find the start of the week (Monday)
    final List<DayPerWeek> days = [];
    DateTime startOfWeek = date.subtract(Duration(days: date.weekday - 1));

    // Print the days of the week
    for (int i = 0; i < 7; i++) {
      DateTime currentDay = startOfWeek.add(Duration(days: i));
      final day = DayPerWeek(
        dayPerMonth: currentDay.day,
        dayPerWeek: currentDay.weekday,
        date: currentDay,
      );
      days.add(day);
    }
    return Week(
      year: date.year,
      month: date.month,
      days: days,
    );
  }
}
