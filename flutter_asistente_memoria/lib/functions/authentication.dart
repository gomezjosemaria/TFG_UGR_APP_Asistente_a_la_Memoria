import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_asistente_memoria/model/user.dart';

class Authentication {

  /*final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  Authentication({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
    _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
*/

  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static CollectionReference _collectionReferenceUsers = FirebaseFirestore.instance.collection('users');

  static Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<void> signUpWithEmailAndPassword(String name, String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await setUserName(_firebaseAuth.currentUser!, name);
      await signInWithEmailAndPassword(email, password);
    } on FirebaseAuthException catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<void> singOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<void> setUserName(User user, String name) async {
    try {
      await _collectionReferenceUsers.doc(user.uid).set({
        'name': name,
      });
    } on FirebaseException catch (e) {
      print(e);
      throw e;
    }
  }

  static UserModel getCurrentUser() {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return UserModel(
        firebaseUser.uid,
        '',
        '',
        '',
        false,
      );
    }
    else {
      return UserModel.empty;
    }
  }

}