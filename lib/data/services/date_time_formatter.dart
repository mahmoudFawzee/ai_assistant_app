import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final class DateTimeFormatter {
  //?we will get the date and the time from use then we will combine them both
  //?in a single var of type date time
  static String dateToString(DateTime date) => DateFormat.yMd().format(date);
  static String timeToString(DateTime time) => DateFormat.Hm().format(time);

  static DateTime dateFromString(String date) => DateTime.parse(date);
  static TimeOfDay timeFromString(String time) {
    final DateTime date = DateTime.parse(time);
    return TimeOfDay.fromDateTime(date);
  }
}
