import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_asistente_memoria/model/medication_model.dart';

class MedicationManager {

  static CollectionReference _collectionReferenceMedication =
  FirebaseFirestore.instance.collection('medication');
  static List<MedicationModel> _medicationActive = <MedicationModel>[];
  static List<MedicationModel> _medicationDeactivate = <MedicationModel>[];

  static List<String> _frequencyOptions = [
    'Diariamente',
    'Cada X horas',
    'Cada X días',
    'En días concretos de la semana'
  ];

  static List<String> _everyHourOptions = ['0.5', '1', '1.5', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];

  static List<String> getFrequencyOptions() {
    return _frequencyOptions;
  }

  static List<String> getEveryXHourOptions() {
    return _everyHourOptions;
  }

  static List<String> getEveryXDayOptions() {
    List<String> options = <String>[];
    int maxDay = 100;
    int minDay = 2;
    for (int i = minDay; i <= maxDay; i++) {
      options.add(i.toString());
    }
    return options;
  }

  static Future<void> saveMedication(MedicationModel medication, String userEmail, bool active) async {
    try {
      if (active) {
        await _collectionReferenceMedication
            .doc(userEmail)
            .collection('active')
            .doc(medication.time + medication.name)
            .set({
          'name': medication.name,
          'time': medication.time,
          'frequency': medication.frequency,
          'frequencyNumber': medication.frequencyNumber,
          'repeatWeekDays': medication.repeatWeekDays,
        });
      }
      else {
        await _collectionReferenceMedication
            .doc(userEmail)
            .collection('deactivate')
            .doc(medication.time + medication.name)
            .set({
          'name': medication.name,
          'time': medication.time,
          'frequency': medication.frequency,
          'frequencyNumber': medication.frequencyNumber,
          'repeatWeekDays': medication.repeatWeekDays,
        });
      }
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  static loadMedication(String userEmail) async {
    try {
      var collectionReferenceMedicationActive = _collectionReferenceMedication.doc(userEmail).collection('active');
      var collectionReferenceMedicationDeactivate = _collectionReferenceMedication.doc(userEmail).collection('deactivate');

      QuerySnapshot querySnapshotActive = await collectionReferenceMedicationActive.get();
      QuerySnapshot querySnapshotDeactivate = await collectionReferenceMedicationDeactivate.get();

      _medicationActive.clear();
      for (int i = 0; i < querySnapshotActive.docs.length; i++) {
        var medication = querySnapshotActive.docs[i];
        var medicationModel = new MedicationModel(
          medication.data()['name'].toString(),
          medication.data()['time'].toString(),
          medication.data()['frequency'],
          medication.data()['frequencyNumber'],
          List<bool>.from(medication.data()['repeatWeekDays']),
        );
        _medicationActive.add(medicationModel);
      }

      _medicationDeactivate.clear();
      for (int i = 0; i < querySnapshotDeactivate.docs.length; i++) {
        var medication = querySnapshotDeactivate.docs[i];
        var medicationModel = new MedicationModel(
          medication.data()['name'].toString(),
          medication.data()['time'].toString(),
          medication.data()['frequency'],
          medication.data()['frequencyNumber'],
          List<bool>.from(medication.data()['repeatWeekDays']),
        );
        _medicationDeactivate.add(medicationModel);
      }
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  static getMedicationActive() {
    return _medicationActive;
  }

  static getMedicationDeactivate() {
    return _medicationDeactivate;
  }

  static deleteMedication(MedicationModel medication, String userEmail, bool active) {
    if (active) {
      try {
        var collectionReferenceMedicationsActive = _collectionReferenceMedication.doc(userEmail).collection('active');
        collectionReferenceMedicationsActive.doc(medication.time + medication.name).delete();
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
    else {
      try {
        var collectionReferenceMedicationsDeactivate = _collectionReferenceMedication.doc(userEmail).collection('deactivate');
        collectionReferenceMedicationsDeactivate.doc(medication.time + medication.name).delete();
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
  }
}