import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_asistente_memoria/model/appointments_model.dart';

class AppointmentManager {
  static CollectionReference _collectionReferenceAppointments =
      FirebaseFirestore.instance.collection('appointments');
  static List<AppointmentModel> _appointmentsActive = <AppointmentModel>[];
  static List<AppointmentModel> _appointmentsDeactivate = <AppointmentModel>[];

  static Future<void> saveAppointment(
      AppointmentModel appointment, String userEmail, bool active) async {
    try {
      if (active) {
        await _collectionReferenceAppointments
            .doc(userEmail)
            .collection('active')
            .doc(appointment.date + appointment.time + appointment.place)
            .set({
          'place': appointment.place,
          'date': appointment.date,
          'time': appointment.time,
        });
      } else {
        await _collectionReferenceAppointments
            .doc(userEmail)
            .collection('deactivate')
            .doc(appointment.date + appointment.time + appointment.place)
            .set({
          'place': appointment.place,
          'date': appointment.date,
          'time': appointment.time,
        });
      }
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  static loadAppointments(String userEmail) async {
    try {
      var collectionReferenceAppointmentsActive =
          _collectionReferenceAppointments.doc(userEmail).collection('active');
      var collectionReferenceAppointmentsDeactivate =
          _collectionReferenceAppointments
              .doc(userEmail)
              .collection('deactivate');

      QuerySnapshot querySnapshotActive =
          await collectionReferenceAppointmentsActive.get();
      QuerySnapshot querySnapshotDeactivate =
          await collectionReferenceAppointmentsDeactivate.get();

      _appointmentsActive.clear();
      for (int i = 0; i < querySnapshotActive.docs.length; i++) {
        var appointment = querySnapshotActive.docs[i];
        var appointmentModel = new AppointmentModel(
          appointment.data()['place'].toString(),
          appointment.data()['date'].toString(),
          appointment.data()['time'].toString(),
        );
        _appointmentsActive.add(appointmentModel);
      }

      _appointmentsDeactivate.clear();
      for (int i = 0; i < querySnapshotDeactivate.docs.length; i++) {
        var appointment = querySnapshotDeactivate.docs[i];
        var appointmentModel = new AppointmentModel(
          appointment.data()['place'].toString(),
          appointment.data()['date'].toString(),
          appointment.data()['time'].toString(),
        );
        _appointmentsDeactivate.add(appointmentModel);
      }
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  static getAppointmentsActive() {
    return _appointmentsActive;
  }

  static getAppointmentsDeactivate() {
    return _appointmentsDeactivate;
  }

  static deleteAppointment(AppointmentModel appointment, String userEmail, bool active) {
    if (active) {
      try {
        var collectionReferenceAppointmentsActive = _collectionReferenceAppointments.doc(userEmail).collection('active');
        collectionReferenceAppointmentsActive.doc(appointment.date + appointment.time + appointment.place).delete();
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
    else {
      try {
        var collectionReferenceAppointmentsDeactivate = _collectionReferenceAppointments.doc(userEmail).collection('deactivate');
        collectionReferenceAppointmentsDeactivate.doc(appointment.date + appointment.time + appointment.place).delete();
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
  }
}
