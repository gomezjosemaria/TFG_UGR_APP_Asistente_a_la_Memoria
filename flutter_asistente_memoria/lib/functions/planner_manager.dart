import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/functions/notification_service.dart';
import 'package:flutter_asistente_memoria/functions/to_string.dart';
import 'package:flutter_asistente_memoria/model/alarm_model.dart';
import 'package:flutter_asistente_memoria/model/appointments_model.dart';
import 'package:flutter_asistente_memoria/model/medication_model.dart';
import 'package:flutter_asistente_memoria/model/time_object_model.dart';
import 'package:intl/intl.dart';

import 'medication_manager.dart';

class PlannerManager {
  static CollectionReference _collectionReferenceAppointments =
      FirebaseFirestore.instance.collection('appointments');
  static CollectionReference _collectionReferenceAlarms =
      FirebaseFirestore.instance.collection('alarms');
  static CollectionReference _collectionReferenceMedication =
      FirebaseFirestore.instance.collection('medication');
  static List<AppointmentModel> _appointmentsToday = <AppointmentModel>[];
  static List<AlarmModel> _alarmsToday = <AlarmModel>[];
  static List<MedicationModel> _medicationToday = <MedicationModel>[];
  static List<TimeObject> _orderByTime = <TimeObject>[];

  static bool isTodayThisDay(String date) {
    DateTime parseDate = DateTime.parse(date);
    DateTime today = DateTime.now();
    bool isToday = false;
    if (today.year == parseDate.year &&
        today.month == parseDate.month &&
        today.day == parseDate.day) {
      isToday = true;
    }
    return isToday;
  }

  static bool isTodayWeekDaySelected(List<bool> weekDays) {
    var day = DateFormat('EEEE').format(DateTime.now());
    print(day);
    var isToday = false;
    if (day == 'Monday' && weekDays[0]) {
      isToday = true;
    } else if (day == 'Tuesday' && weekDays[1]) {
      isToday = true;
    } else if (day == 'Wednesday' && weekDays[2]) {
      isToday = true;
    } else if (day == 'Thursday' && weekDays[3]) {
      isToday = true;
    } else if (day == 'Friday' && weekDays[4]) {
      isToday = true;
    } else if (day == 'Saturday' && weekDays[5]) {
      isToday = true;
    } else if (day == 'Sunday' && weekDays[5]) {
      isToday = true;
    }
    return isToday;
  }

  static loadTodayMedication(String userEmail) async {
    try {
      var collectionReferenceMedicationActive =
          _collectionReferenceMedication.doc(userEmail).collection('active');
      QuerySnapshot querySnapshotActive =
          await collectionReferenceMedicationActive.get();
      _medicationToday.clear();
      for (int i = 0; i < querySnapshotActive.docs.length; i++) {
        var medication = querySnapshotActive.docs[i];
        var add = false;
        if (DateTime.now()
            .isAfter(DateTime.parse(medication.data()['date'].toString()))) {
          if (medication.data()['frequency'] ==
                  MedicationManager.getFrequencyOptions()[0] ||
              medication.data()['frequency'] ==
                  MedicationManager.getFrequencyOptions()[1]) {
            add = true;
          } else if (medication.data()['frequency'] ==
              MedicationManager.getFrequencyOptions()[2]) {
            Duration difference = DateTime.now().difference(
                DateTime.parse(medication.data()['date'].toString()));
            if (difference.inDays % medication.data()['frequencyNumber'] == 0) {
              add = true;
            }
          } else if (medication.data()['frequency'] ==
                  MedicationManager.getFrequencyOptions()[3] &&
              isTodayWeekDaySelected(
                  List<bool>.from(medication.data()['repeatWeekDays']))) {
            add = true;
          }
        }
        if (add) {
          var medicationModel = new MedicationModel(
            medication.data()['name'].toString(),
            medication.data()['date'].toString(),
            medication.data()['time'].toString(),
            medication.data()['frequency'],
            medication.data()['frequencyNumber'],
            List<bool>.from(medication.data()['repeatWeekDays']),
          );
          _medicationToday.add(medicationModel);
        }
      }
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  static List<AlarmModel> getTodayAlarms() {
    return _alarmsToday;
  }

  static loadTodayAlarm(String userEmail) async {
    try {
      var collectionReferenceAlarmsActive =
          _collectionReferenceAlarms.doc(userEmail).collection('active');
      QuerySnapshot querySnapshotActive =
          await collectionReferenceAlarmsActive.get();

      _alarmsToday.clear();
      for (int i = 0; i < querySnapshotActive.docs.length; i++) {
        var alarm = querySnapshotActive.docs[i];
        var add = false;
        if (!alarm.data()['repeat']) {
          add = true;
        } else if (isTodayWeekDaySelected(
            List<bool>.from(alarm.data()['repeatWeekDays']))) {
          print('repeat');
          add = true;
        }
        if (add) {
          var alarmModel = new AlarmModel(
            alarm.data()['title'].toString(),
            alarm.data()['time'].toString(),
            alarm.data()['repeat'],
            List<bool>.from(alarm.data()['repeatWeekDays']),
          );
          _alarmsToday.add(alarmModel);
        }
      }
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  static List<MedicationModel> getTodayMedication() {
    print("EMPIEZA" + _medicationToday.toString() + "ACABA");
    return _medicationToday;
  }

  static loadTodayAppointments(String userEmail) async {
    try {
      var collectionReferenceAppointmentsActive =
          _collectionReferenceAppointments.doc(userEmail).collection('active');
      QuerySnapshot querySnapshotActive =
          await collectionReferenceAppointmentsActive.get();

      _appointmentsToday.clear();

      for (int i = 0; i < querySnapshotActive.docs.length; i++) {
        var appointment = querySnapshotActive.docs[i];
        if (isTodayThisDay(appointment.data()['date'].toString())) {
          var appointmentModel = new AppointmentModel(
            appointment.data()['place'].toString(),
            appointment.data()['date'].toString(),
            appointment.data()['time'].toString(),
          );
          _appointmentsToday.add(appointmentModel);
        }
      }
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  static List<AppointmentModel> getTodayAppointments() {
    return _appointmentsToday;
  }

  static orderByTime() {
    if (_alarmsToday.length > 0 && _medicationToday.length > 0) {
      _orderByTime = orderByTimeTwoLists(_alarmsToday, _medicationToday);
      if (_appointmentsToday.length > 0) {
        _orderByTime = orderByTimeTwoLists(_orderByTime, _appointmentsToday);
      }
    } else if (_alarmsToday.length > 0) {
      if (_appointmentsToday.length > 0) {
        _orderByTime = orderByTimeTwoLists(_alarmsToday, _appointmentsToday);
      } else {
        _orderByTime = _alarmsToday;
      }
    } else if (_medicationToday.length > 0) {
      if (_appointmentsToday.length > 0) {
        _orderByTime =
            orderByTimeTwoLists(_medicationToday, _appointmentsToday);
      } else {
        _orderByTime = _medicationToday;
      }
    } else {
      _orderByTime = _appointmentsToday;
    }
  }

  static List<Object> getOrderByTime() {
    return _orderByTime;
  }

  static void setAlarms() {
    for (int i = 0; i < _alarmsToday.length; i++) {
      setAlarmNotification(_alarmsToday[i], i);
    }
    for (int i = 0; i < _medicationToday.length; i++) {
      setMedicationNotification(_medicationToday[i], 100 + i);
    }
    for (int i = 0; i < _appointmentsToday.length; i++) {
      setAppointmentNotification(_appointmentsToday[i], 200 + i);
    }
  }

  static void setAlarmNotification(AlarmModel alarmModel, int id) {
    TimeOfDay timeOfDay = ToString.stringToTimeOfDay(alarmModel.time);
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    NotificationService.showScheduledNotification(id: id, title: alarmModel.tittle, scheduledDate: dateTime);
  }

  static void setMedicationNotification(MedicationModel medicationModel, int id) {
    TimeOfDay timeOfDay = ToString.stringToTimeOfDay(medicationModel.time);
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    NotificationService.showScheduledNotification(id: id, title: medicationModel.name, scheduledDate: dateTime);
  }

  static void setAppointmentNotification(AppointmentModel appointmentModel, int id) {
    TimeOfDay timeOfDay = ToString.stringToTimeOfDay(appointmentModel.time);
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    NotificationService.showScheduledNotification(id: id, title: appointmentModel.place, scheduledDate: dateTime);
  }

  static List<TimeObject> orderByTimeTwoLists(
      List<TimeObject> first, List<TimeObject> second) {
    List<TimeObject> orderList = <TimeObject>[];
    List<TimeOfDay> firstTime = <TimeOfDay>[];
    List<TimeOfDay> secondTime = <TimeOfDay>[];

    for (int i = 0; i < first.length; i++) {
      firstTime.add(ToString.stringToTimeOfDay(first[i].time));
    }

    for (int i = 0; i < second.length; i++) {
      DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
      firstTime.add(dateTime);
    }

    for (int i = 0; i < first.length; i++) {
      for (int j = i; j < first.length - i - 1; j++) {
        if (firstTime[j].hour > firstTime[j + 1].hour ||
            firstTime[j].hour == firstTime[j + 1].hour &&
                firstTime[j].minute > firstTime[j + 1].minute) {
          var auxToday = first[j + 1];
          first[j + 1] = first[j];
          first[j] = auxToday;
          var auxTime = firstTime[j + 1];
          firstTime[j + 1] = firstTime[j];
          firstTime[j] = auxTime;
        }
      }
    }

    for (int i = 0; i < second.length; i++) {
      for (int j = i; j < second.length - i - 1; j++) {
        if (secondTime[j].hour > secondTime[j + 1].hour ||
            secondTime[j].hour == secondTime[j + 1].hour &&
                secondTime[j].minute > secondTime[j + 1].minute) {
          var auxToday = second[j + 1];
          second[j + 1] = second[j];
          second[j] = auxToday;
          var auxTime = secondTime[j + 1];
          secondTime[j + 1] = secondTime[j];
          secondTime[j] = auxTime;
        }
      }
    }

    int firstIndex = 0;
    int secondIndex = 0;

    for (int i = 0; i < first.length + second.length; i++) {
      if (firstTime[firstIndex].hour < secondTime[secondIndex].hour) {
        orderList.add(first[firstIndex]);
        if (firstIndex == first.length - 1) {
          firstTime[firstIndex] = new TimeOfDay(hour: 23, minute: 59);
        } else {
          firstIndex++;
        }
      } else if (firstTime[firstIndex].hour == secondTime[secondIndex].hour) {
        if (firstTime[firstIndex].minute < secondTime[secondIndex].minute) {
          orderList.add(first[firstIndex]);
          if (firstIndex == first.length - 1) {
            firstTime[firstIndex] = new TimeOfDay(hour: 23, minute: 59);
          } else {
            firstIndex++;
          }
        } else {
          orderList.add(second[secondIndex]);
          if (secondIndex == second.length - 1) {
            secondTime[secondIndex] = new TimeOfDay(hour: 23, minute: 59);
          } else {
            secondIndex++;
          }
        }
      } else {
        orderList.add(second[secondIndex]);
        if (secondIndex == second.length - 1) {
          secondTime[secondIndex] = new TimeOfDay(hour: 23, minute: 59);
        } else {
          secondIndex++;
        }
      }
    }

    return orderList;
  }
}
