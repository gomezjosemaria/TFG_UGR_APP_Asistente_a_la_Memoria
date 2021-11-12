import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_asistente_memoria/model/note_model.dart';

class NoteManager {

  static CollectionReference _collectionReferenceNotes =
  FirebaseFirestore.instance.collection('notes');
  static List<NoteModel> _notes = <NoteModel>[];

  static Future<void> saveNote(NoteModel note, String userEmail) async {
    try {
      await _collectionReferenceNotes
          .doc(userEmail)
          .collection('active')
          .doc(note.time)
          .set({
        'text': note.text,
        'time': note.time,
      });
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  static loadNotes(String userEmail) async {
    try {
      var collectionReferenceNotesActive = _collectionReferenceNotes.doc(userEmail).collection('active');

      QuerySnapshot querySnapshotActive = await collectionReferenceNotesActive.get();

      _notes.clear();
      for (int i = 0; i < querySnapshotActive.docs.length; i++) {
        var note = querySnapshotActive.docs[i];
        var noteModel = new NoteModel(
          note.data()['text'].toString(),
          note.data()['time'].toString(),
        );
        _notes.add(noteModel);
      }
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  static getNotes() {
    return _notes;
  }

  static deleteNote(NoteModel note, String userEmail) {
    try {
      var collectionReferenceNotesActive = _collectionReferenceNotes.doc(userEmail).collection('active');
      collectionReferenceNotesActive.doc(note.time).delete();
    } on FirebaseException catch (e) {
      throw (e);
    }
  }
}