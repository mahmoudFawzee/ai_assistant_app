import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final class DateTimeFormatter {
  //?we will get the date and the time from use then we will combine them both
  //?in a single var of type date time
  static final _dateFormat = DateFormat('yyyy-MM-dd');
  //?!we make a custom time formatting because we will
  //?!pass the task as json through the pages and we will
  //?!decode it but we must not use char ":" when decode using jsonDecode.
  //?!and we also can't use this char "/" through routing
  static final _timeFormat = DateFormat('HH-mm');
  static String dateToString(DateTime date) => _dateFormat.format(date);
  static String timeToString(DateTime time) => _timeFormat.format(time);

  static DateTime dateFromString(String date) {
    log('un accepted date : $date');
    return DateTime.parse(date.replaceAll('/', '-'));
  }

  static TimeOfDay timeFromString(String time) {
    log('pre time reformatting : $time');
    //?we make this because this obj can not accept time directly but
    //?accept it like this 2012-02-27 13:27:00
    final reFormattedTime = '$time:00'.replaceAll('-', ':');
    final date = DateTime.parse('2012-02-27 $reFormattedTime');

    log('time reformatting : $date');
    return TimeOfDay.fromDateTime(date);
  }

  static String dateTimeToString(DateTime dateTime) {
    final date = dateToString(dateTime);
    final time = timeToString(dateTime);
    return '$date $time';
  }

  static DateTime createDateTime({
    required DateTime date,
    required TimeOfDay time,
  }) {
    final year = date.year;
    final month = date.month;
    final day = date.day;
    final hour = time.hour;
    final minute = time.minute;
    return DateTime(year, month, day, hour, minute);
  }
}
