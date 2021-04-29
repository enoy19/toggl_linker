import 'package:flutter/material.dart';

class DateUtil {
  DateUtil._();

  static DateTime lastMonday() {
    final oneWeekEarlier = DateTime.now().subtract(Duration(days: 7));

    DateTime monday = oneWeekEarlier;
    while (monday.weekday != 1) {
      monday = monday.subtract(Duration(days: 1));
    }
    return monday;
  }

  static DateTimeRange lastWeekRange() {
    final monday = lastMonday();
    final sunday = monday.add(Duration(days: 6));

    return DateTimeRange(
      start: DateTime(monday.year, monday.month, monday.day),
      end: DateTime(sunday.year, sunday.month, sunday.day),
    );
  }
}
