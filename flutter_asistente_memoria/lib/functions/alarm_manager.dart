import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_asistente_memoria/functions/authentication.dart';
import 'package:flutter_asistente_memoria/model/alarm.dart';
import 'package:flutter_asistente_memoria/model/user.dart';

class AlarmManager {

  static CollectionReference _collectionReferenceAlarms =
    FirebaseFirestore.instance.collection('alarms');

  static Future<void> saveAlarm(AlarmModel alarm) async {
    UserModel user = Authentication.getCurrentUser();
    print("saveAlarm");
    if (user.id == '') {
      print("useIsValid");
      try {
        await _collectionReferenceAlarms.doc('test').set({
          'caregiver': user.id,
          'title': alarm.tittle,
          'time': alarm.time,
          'repeat': alarm.repeat,
          'repeatWeekDays': alarm.repeatWeekDays,
        });
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
    else {
      print("userIsNotValid");
    }
  }
}