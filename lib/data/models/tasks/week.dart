final class Week {
  final int year;
  final int month;
  final List<DayPerWeek> days;
  const Week({
    required this.year,
    required this.month,
    required this.days,
  });
  @override
  String toString() {
    return ' month : $month , year : $year , days : $days , nDays : ${days.length}';
  }
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

  String getDayPerMonth() => _dayPerMonth.toString().padLeft(2, '0');

  String _handleTodayString(int weekDay) {
    switch (weekDay) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wen';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';

      default:
        return 'Sun';
    }
  }

  @override
  String toString() {
    return ' month day : $_dayPerMonth , week day : $_dayPerWeek , day string : ${getStringDay()}';
  }
}
