final class Week {
  final int year;
  final int month;
  final List<DayPerWeek> days;
  const Week({
    required this.year,
    required this.month,
    required this.days,
  });
  bool monthMatch(int month) => month == this.month;
  @override
  String toString() {
    return ' month : $month , year : $year , days : $days , nDays : ${days.length}';
  }
}

final class DayPerWeek {
  final int _dayPerMonth;
  final int _dayPerWeek;
  final DateTime _date;
  const DayPerWeek({
    required int dayPerMonth,
    required int dayPerWeek,
    required DateTime date,
  })  : _dayPerMonth = dayPerMonth,
        _dayPerWeek = dayPerWeek,
        _date = date;
  String getStringDay() {
    return _handleTodayString(_dayPerWeek);
  }

  bool isMatched(DateTime dayDate) {
    if (date.day != dayDate.day) return false;
    if (date.month != dayDate.month) return false;
    if (date.year != dayDate.year) return false;
    return true;
  }

  DateTime get date => _date;
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
