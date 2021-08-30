import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_asistente_memoria/model/alarm_model.dart';

class AlarmManager {

  static CollectionReference _collectionReferenceAlarms =
      FirebaseFirestore.instance.collection('alarms');
  static List<AlarmModel> _alarmsActive = <AlarmModel>[];
  static List<AlarmModel> _alarmsDeactivate = <AlarmModel>[];

  static Future<void> saveAlarm(AlarmModel alarm, String userEmail, bool active) async {
    try {
      if (active) {
        await _collectionReferenceAlarms
            .doc(userEmail)
            .collection('active')
            .doc(alarm.time + alarm.tittle)
            .set({
          'title': alarm.tittle,
          'time': alarm.time,
          'repeat': alarm.repeat,
          'repeatWeekDays': alarm.repeatWeekDays,
        });
      }
      else {
        await _collectionReferenceAlarms
            .doc(userEmail)
            .collection('deactivate')
            .doc(alarm.time + alarm.tittle)
            .set({
          'title': alarm.tittle,
          'time': alarm.time,
          'repeat': alarm.repeat,
          'repeatWeekDays': alarm.repeatWeekDays,
        });
      }
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  static loadAlarms(String userEmail) async {
    try {
      var collectionReferenceAlarmsActive = _collectionReferenceAlarms.doc(userEmail).collection('active');
      var collectionReferenceAlarmsDeactivate = _collectionReferenceAlarms.doc(userEmail).collection('deactivate');

      QuerySnapshot querySnapshotActive = await collectionReferenceAlarmsActive.get();
      QuerySnapshot querySnapshotDeactivate = await collectionReferenceAlarmsDeactivate.get();

      _alarmsActive.clear();
      for (int i = 0; i < querySnapshotActive.docs.length; i++) {
        var alarm = querySnapshotActive.docs[i];
        var alarmModel = new AlarmModel(
          alarm.data()['title'].toString(),
          alarm.data()['time'].toString(),
          alarm.data()['repeat'],
          List<bool>.from(alarm.data()['repeatWeekDays']),
        );
        _alarmsActive.add(alarmModel);
      }

      _alarmsDeactivate.clear();
      for (int i = 0; i < querySnapshotDeactivate.docs.length; i++) {
        var alarm = querySnapshotDeactivate.docs[i];
        var alarmModel = new AlarmModel(
          alarm.data()['title'].toString(),
          alarm.data()['time'].toString(),
          alarm.data()['repeat'],
          List<bool>.from(alarm.data()['repeatWeekDays']),
        );
        _alarmsDeactivate.add(alarmModel);
      }
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  static getAlarmsActive() {
    return _alarmsActive;
  }

  static getAlarmsDeactivate() {
    return _alarmsDeactivate;
  }

  static deleteAlarm(AlarmModel alarm, String userEmail, bool active) {
    if (active) {
      try {
        var collectionReferenceAlarmsActive = _collectionReferenceAlarms.doc(userEmail).collection('active');
        collectionReferenceAlarmsActive.doc(alarm.time + alarm.tittle).delete();
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
    else {
      try {
        var collectionReferenceAlarmsDeactivate = _collectionReferenceAlarms.doc(userEmail).collection('deactivate');
        collectionReferenceAlarmsDeactivate.doc(alarm.time + alarm.tittle).delete();
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
  }
}