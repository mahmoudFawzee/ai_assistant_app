import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final class DateTimeFormatter {
  //?we will get the date and the time from use then we will combine them both
  //?in a single var of type date time
  static final _format = DateFormat('yyyy-MM-dd');
  static String dateToString(DateTime date) => _format.format(date);
  static String timeToString(DateTime time) => DateFormat.Hm().format(time);

  static DateTime dateFromString(String date) {
    return DateTime.parse(date.replaceAll('/', '-'));
  }

  static TimeOfDay timeFromString(String time) {
    //?we make this because this obj can not accept time directly but
    //?accept it like this 2012-02-27 13:27:00
    final DateTime date = DateTime.parse('2012-02-27 $time:00');
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
