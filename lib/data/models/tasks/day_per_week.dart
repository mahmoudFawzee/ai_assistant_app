final class Week {
  final int year;
  final int month;
  final List<DayPerWeek> days;
  const Week({
    required this.year,
    required this.month,
    required this.days,
  });
}

final class DayPerWeek {
  final int _dayPerMonth;
  final int _dayPerWeek;
  const DayPerWeek({
    required int dayPerMonth,
    required int dayPerWeek,
  })  : _dayPerMonth = dayPerMonth,
        _dayPerWeek = dayPerWeek;
  String getStringDay() {
    return _handleTodayString(_dayPerWeek);
  }

  String getDayPerMonth() => _dayPerMonth.toString().padLeft(2);

  String _handleTodayString(int weekDay) {
    switch (weekDay) {
      case 1:
        return 'mon';
      case 2:
        return 'tues';
      case 3:
        return 'wen';
      case 4:
        return 'thur';
      case 5:
        return 'fri';
      case 6:
        return 'sat';

      default:
        return 'sun';
    }
  }
}
