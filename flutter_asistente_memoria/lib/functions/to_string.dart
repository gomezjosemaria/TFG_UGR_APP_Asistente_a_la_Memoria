import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  static randomString(int length) {
    var random = Random.secure();
    return String.fromCharCodes(List.generate(length, (index) => random.nextInt(33) + 89));
  }

  static TimeOfDay stringToTimeOfDay(String time) {
    DateTime dateTime = DateFormat("h:mm a").parse(time);
    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);
    return timeOfDay;
  }

  static doubleToString(double number) {
    if (number - number.floor() == 0.0) {
      return number.floor().toString();
    }
    else {
      return number.toString();
    }
  }

  static doubleStringToString(String doubleString) {
    if (doubleString.endsWith('0')) {
      return doubleString.substring(0, doubleString.indexOf('.'));
    }
    else {
      return doubleString;
    }
  }

}