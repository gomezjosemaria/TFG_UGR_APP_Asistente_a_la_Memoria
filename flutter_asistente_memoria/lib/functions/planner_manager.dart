import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/functions/notification_service.dart';
import 'package:flutter_asistente_memoria/functions/to_string.dart';
import 'package:flutter_asistente_memoria/model/alarm_model.dart';
import 'package:flutter_asistente_memoria/model/appointments_model.dart';
import 'package:flutter_asistente_memoria/model/medication_model.dart';
import 'package:flutter_asistente_memoria/model/time_object_model.dart';
import 'package:flutter_asistente_memoria/model/user.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

  static Future<void> loadTodayMedication(String userEmail) async {
    print('load medication');
    try {
      var collectionReferenceMedicationActive =
          _collectionReferenceMedication.doc(userEmail).collection('active');
      QuerySnapshot querySnapshotActive =
          await collectionReferenceMedicationActive.get();
      _medicationToday.clear();
      for (int i = 0; i < querySnapshotActive.docs.length; i++) {
        print(i.toString());
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
          TimeOfDay timeOfDay = ToString.stringToTimeOfDay(medicationModel.time);
          DateTime now = DateTime.now();
          DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
          if (dateTime.isAfter(DateTime.now())) {
            _medicationToday.add(medicationModel);
          }
        }
      }
    } on FirebaseException catch (e) {
      throw (e);
    }
    _medicationToday = _orderMedication(_medicationToday);
    print(_medicationToday.toString());
  }

  static List<AlarmModel> getTodayAlarms() {
    return _alarmsToday;
  }

  static Future<void> loadTodayAlarm(String userEmail) async {
    print('load alarms');
    try {
      var collectionReferenceAlarmsActive =
          _collectionReferenceAlarms.doc(userEmail).collection('active');
      QuerySnapshot querySnapshotActive =
          await collectionReferenceAlarmsActive.get();

      _alarmsToday.clear();
      for (int i = 0; i < querySnapshotActive.docs.length; i++) {
        print(i.toString());
        var alarm = querySnapshotActive.docs[i];
        var add = false;
        if (!alarm.data()['repeat']) {
          add = true;
        } else if (isTodayWeekDaySelected(
            List<bool>.from(alarm.data()['repeatWeekDays']))) {
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
    _alarmsToday = _orderAlarms(_alarmsToday);
    print(_alarmsToday.toString());
  }

  static List<MedicationModel> getTodayMedication() {
    return _medicationToday;
  }

  static loadTodayAppointments(String userEmail) async {
    print('load appointments');
    try {
      var collectionReferenceAppointmentsActive =
          _collectionReferenceAppointments.doc(userEmail).collection('active');
      QuerySnapshot querySnapshotActive =
          await collectionReferenceAppointmentsActive.get();

      _appointmentsToday.clear();

      for (int i = 0; i < querySnapshotActive.docs.length; i++) {
        print(i.toString());
        var appointment = querySnapshotActive.docs[i];
        if (isTodayThisDay(appointment.data()['date'].toString())) {
          var appointmentModel = new AppointmentModel(
            appointment.data()['place'].toString(),
            appointment.data()['date'].toString(),
            appointment.data()['time'].toString(),
          );
          TimeOfDay timeOfDay = ToString.stringToTimeOfDay(appointmentModel.time);
          DateTime now = DateTime.now();
          DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
          if (dateTime.isAfter(DateTime.now())) {
            _appointmentsToday.add(appointmentModel);
          }
        }
      }
    } on FirebaseException catch (e) {
      throw (e);
    }
    _appointmentsToday = _orderAppointment(_appointmentsToday);
    print('TodayAppointments'+_appointmentsToday.toString());
  }

  static List<AppointmentModel> getTodayAppointments() {
    return _appointmentsToday;
  }

  static orderByTime() {
    List<TimeObject> aux = new List.from(_alarmsToday)..addAll(_medicationToday);
    _orderByTime = new List.from(aux)..addAll(_appointmentsToday);
  }

  static List<Object> getOrderByTime() {
    return _orderByTime;
  }

  static Future<void> loadAll() async {
    String email;
    if (Authentication.getUserRole() == UserRole.caregiver) {
      email = Authentication.getUserBond();
    }
    else {
      email = Authentication.getCurrentUserEmail();
    }
    await loadTodayMedication(email);
    await loadTodayAppointments(email);
    await loadTodayAlarm(email);
    orderByTime();
    await setAlarms();
    print ("Notifications");
    List<ActiveNotification> listNotifications = <ActiveNotification>[];
    listNotifications = await NotificationService.getNotifications();
    listNotifications.toString();
  }

  static Future<void> setAlarms() async {
    NotificationService.deleteAllNotifications();
    print('START');
    for (int i = 0; i < _alarmsToday.length; i++) {
      TimeOfDay timeOfDay = ToString.stringToTimeOfDay(_alarmsToday[i].time);
      DateTime now = DateTime.now();
      print('NOW' + now.toString());
      DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
      print(i.toString() + ' ' + _alarmsToday[i].toString());

      if (dateTime.isAfter(DateTime.now())) {
        await setAlarmNotification(_alarmsToday[i], i);
        print('YES');
      }
      else {
        print ('NO');
      }
    }
    for (int i = 0; i < _medicationToday.length; i++) {
      TimeOfDay timeOfDay = ToString.stringToTimeOfDay(_medicationToday[i].time);
      DateTime now = DateTime.now();
      DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
      if (dateTime.isAfter(DateTime.now())) {
        await setMedicationNotification(_medicationToday[i], 100 + i);
      }
    }
    for (int i = 0; i < _appointmentsToday.length; i++) {
      TimeOfDay timeOfDay = ToString.stringToTimeOfDay(_appointmentsToday[i].time);
      DateTime now = DateTime.now();
      DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
      if (dateTime.isAfter(DateTime.now())) {
        await setAppointmentNotification(_appointmentsToday[i], 200 + i);
      }
    }
  }

  static Future<void> setAlarmNotification(AlarmModel alarmModel, int id) async {
    TimeOfDay timeOfDay = ToString.stringToTimeOfDay(alarmModel.time);
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    await NotificationService.showScheduledNotification(id: id, title: 'Alarma', body: alarmModel.tittle, scheduledDate: dateTime);
  }

  static Future<void> setMedicationNotification(MedicationModel medicationModel, int id) async {
    TimeOfDay timeOfDay = ToString.stringToTimeOfDay(medicationModel.time);
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    await NotificationService.showScheduledNotification(id: id, title: 'Medicación', body: medicationModel.name, scheduledDate: dateTime);
  }

  static Future<void> setAppointmentNotification(AppointmentModel appointmentModel, int id) async {
    TimeOfDay timeOfDay = ToString.stringToTimeOfDay(appointmentModel.time);
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    await NotificationService.showScheduledNotification(id: id, title: 'Cita Médica', body: appointmentModel.place, scheduledDate: dateTime);
  }

  static List<TimeObject> orderByTimeTwoLists(
      List<TimeObject> first, List<TimeObject> second) {
    List<TimeObject> orderList = <TimeObject>[];
    List<DateTime> firstTime = <DateTime>[];
    List<DateTime> secondTime = <DateTime>[];
    DateTime now = DateTime.now();

    for (int i = 0; i < first.length; i++) {
      TimeOfDay timeOfDay = ToString.stringToTimeOfDay(first[i].time);
      DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
      firstTime.add(dateTime);
    }

    for (int i = 0; i < second.length; i++) {
      TimeOfDay timeOfDay = ToString.stringToTimeOfDay(second[i].time);
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
          firstTime[firstIndex] = DateTime(now.year, now.month, now.day, 23, 59);
        } else {
          firstIndex++;
        }
      } else if (firstTime[firstIndex].hour == secondTime[secondIndex].hour) {
        if (firstTime[firstIndex].minute < secondTime[secondIndex].minute) {
          orderList.add(first[firstIndex]);
          if (firstIndex == first.length - 1) {
            firstTime[firstIndex] = DateTime(now.year, now.month, now.day, 23, 59);
          } else {
            firstIndex++;
          }
        } else {
          orderList.add(second[secondIndex]);
          if (secondIndex == second.length - 1) {
            secondTime[secondIndex] = DateTime(now.year, now.month, now.day, 23, 59);
          } else {
            secondIndex++;
          }
        }
      } else {
        orderList.add(second[secondIndex]);
        if (secondIndex == second.length - 1) {
          secondTime[secondIndex] = DateTime(now.year, now.month, now.day, 23, 59);
        } else {
          secondIndex++;
        }
      }
    }

    return orderList;
  }

  static List<AlarmModel> _orderAlarms(List<AlarmModel> alarms) {
    DateTime now = DateTime.now();
    List<AlarmModel> timeObjectAux = alarms;

    for (int i = 0; i < timeObjectAux.length - 1; i++) {
      for (int j = i + 1; j < timeObjectAux.length; j++) {
        TimeOfDay timeOfDayI = ToString.stringToTimeOfDay(timeObjectAux[i].time);
        DateTime dateTimeI = DateTime(now.year, now.month, now.day, timeOfDayI.hour, timeOfDayI.minute);
        TimeOfDay timeOfDayJ = ToString.stringToTimeOfDay(timeObjectAux[j].time);
        DateTime dateTimeJ = DateTime(now.year, now.month, now.day, timeOfDayJ.hour, timeOfDayJ.minute);
        print(dateTimeI.toString() + '    ' + dateTimeJ.toString());
        if (dateTimeI.isBefore(dateTimeJ)) {
          AlarmModel aux = timeObjectAux[i];
          timeObjectAux[i] = timeObjectAux[j];
          timeObjectAux[j] = aux;
        }
        else {
          AlarmModel aux = timeObjectAux[j];
          timeObjectAux[j] = timeObjectAux[i];
          timeObjectAux[i] = aux;
        }
      }
    }

    print(timeObjectAux.toString());
    return timeObjectAux;
  }

  static List<MedicationModel> _orderMedication(List<MedicationModel> list) {
    DateTime now = DateTime.now();
    List<MedicationModel> timeObjectAux = list;

    for (int i = 0; i < timeObjectAux.length - 1; i++) {
      for (int j = i + 1; j < timeObjectAux.length; j++) {
        TimeOfDay timeOfDayI = ToString.stringToTimeOfDay(timeObjectAux[i].time);
        DateTime dateTimeI = DateTime(now.year, now.month, now.day, timeOfDayI.hour, timeOfDayI.minute);
        TimeOfDay timeOfDayJ = ToString.stringToTimeOfDay(timeObjectAux[j].time);
        DateTime dateTimeJ = DateTime(now.year, now.month, now.day, timeOfDayJ.hour, timeOfDayJ.minute);
        if (dateTimeI.isAfter(dateTimeJ)) {
          MedicationModel aux = timeObjectAux[i];
          timeObjectAux[i] = timeObjectAux[j];
          timeObjectAux[j] = aux;
        }
        else {
          MedicationModel aux = timeObjectAux[j];
          timeObjectAux[j] = timeObjectAux[i];
          timeObjectAux[i] = aux;
        }
      }
    }

    return timeObjectAux;
  }

  static List<AppointmentModel> _orderAppointment(List<AppointmentModel> list) {
    DateTime now = DateTime.now();
    List<AppointmentModel> timeObjectAux = list;

    for (int i = 0; i < timeObjectAux.length - 1; i++) {
      for (int j = i + 1; j < timeObjectAux.length; j++) {
        TimeOfDay timeOfDayI = ToString.stringToTimeOfDay(timeObjectAux[i].time);
        DateTime dateTimeI = DateTime(now.year, now.month, now.day, timeOfDayI.hour, timeOfDayI.minute);
        TimeOfDay timeOfDayJ = ToString.stringToTimeOfDay(timeObjectAux[j].time);
        DateTime dateTimeJ = DateTime(now.year, now.month, now.day, timeOfDayJ.hour, timeOfDayJ.minute);
        if (dateTimeI.isAfter(dateTimeJ)) {
          AppointmentModel aux = timeObjectAux[i];
          timeObjectAux[i] = timeObjectAux[j];
          timeObjectAux[j] = aux;
        }
        else {
          AppointmentModel aux = timeObjectAux[j];
          timeObjectAux[j] = timeObjectAux[i];
          timeObjectAux[i] = aux;
        }
      }
    }

    return timeObjectAux;
  }

}

