import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_asistente_memoria/model/activity_model.dart';

class ActivityManager {
  static CollectionReference _collectionReferenceActivities =
      FirebaseFirestore.instance.collection('activities');
  static List<ActivityModel> _activities = <ActivityModel>[];

  static Future<void> saveActivity(
      ActivityModel activity, String userEmail) async {
    try {
      await _collectionReferenceActivities
          .doc(userEmail)
          .collection('active')
          .doc(activity.tittle)
          .set({
        'title': activity.tittle,
        'steps': activity.steps,
      });
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  static loadActivities(String userEmail) async {
    try {
      var collectionReferenceActivitiesActive =
          _collectionReferenceActivities.doc(userEmail).collection('active');

      QuerySnapshot querySnapshotActive =
          await collectionReferenceActivitiesActive.get();

      _activities.clear();
      for (int i = 0; i < querySnapshotActive.docs.length; i++) {
        var activity = querySnapshotActive.docs[i];
        var activityModel = new ActivityModel(
          activity.data()['title'].toString(),
          List<String>.from(activity.data()['steps']),
        );
        _activities.add(activityModel);
      }
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  static getActivities() {
    return _activities;
  }

  static deleteActivity(ActivityModel activity, String userEmail) {
    try {
      var collectionReferenceActivitiesActive =
          _collectionReferenceActivities.doc(userEmail).collection('active');
      collectionReferenceActivitiesActive.doc(activity.tittle).delete();
    } on FirebaseException catch (e) {
      throw (e);
    }
  }
}
