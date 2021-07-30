import 'package:flutter/material.dart';

class ToString {

  static String timeOfDayToString(TimeOfDay time) {

    String _hour;
    String _minute;
    String _period;

    if (time.hourOfPeriod >= 10) {
      _hour = time.hourOfPeriod.toString();
    }
    else {
      _hour = '0' + time.hourOfPeriod.toString();
    }

    if (time.minute >= 10) {
      _minute = time.minute.toString();
    }
    else {
      _minute = '0' + time.minute.toString();
    }

    if (time.period == DayPeriod.am) {
      _period = 'AM';
    }
    else {
      _period = 'PM';
    }

    return _hour + ':' + _minute + ' ' + _period;
  }

}