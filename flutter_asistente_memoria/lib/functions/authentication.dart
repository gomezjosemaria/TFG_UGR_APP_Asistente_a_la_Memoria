import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_asistente_memoria/model/user.dart';

class Authentication {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static CollectionReference _collectionReferenceUsers =
      FirebaseFirestore.instance.collection('users');
  static UserRole _userRole = UserRole.unselected;

  static Future<void> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  static Future<void> signUpWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await signInWithEmailAndPassword(email, password);
      await setUserName(name);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  static Future<void> singOut() async {
    try {
      await _firebaseAuth.signOut();
      await setUserRole(UserRole.unselected);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  static Future<void> setUserName(String name) async {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      try {
        firebaseUser.updateProfile(
          displayName: name,
        );
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
  }

  static Future<void> setUserRole(UserRole role) async {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      try {
        await _collectionReferenceUsers.doc(firebaseUser.uid).set({
          'role': userRoleToString(role),
        });
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
  }

  static Future<void> loadUserRole() async {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      try {
        await _collectionReferenceUsers
            .doc(firebaseUser.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            if (documentSnapshot.data()!['role'].toString() == 'caregiver') {
              Authentication._userRole = UserRole.caregiver;
            } else if (documentSnapshot.data()!['role'].toString() ==
                'caregiver') {
              Authentication._userRole = UserRole.careReceiver;
            } else {
              Authentication._userRole = UserRole.unselected;
            }
          }
        });
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
  }

  static UserRole getUserRole() {
    return Authentication._userRole;
  }

  static UserModel getCurrentUser() {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return UserModel(
        firebaseUser.uid,
        firebaseUser.email!,
        firebaseUser.displayName!,
        '',
      );
    } else {
      return UserModel.empty;
    }
  }
}
