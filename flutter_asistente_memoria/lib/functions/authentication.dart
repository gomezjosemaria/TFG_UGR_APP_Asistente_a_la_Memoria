import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_asistente_memoria/functions/to_string.dart';
import 'package:flutter_asistente_memoria/model/user.dart';

class Authentication {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static CollectionReference _collectionReferenceUsers =
      FirebaseFirestore.instance.collection('users');
  static UserRole _userRole = UserRole.unselected;
  static String _bondCode = '';
  static String _userBond = '';
  static List<String> _userBonds = List.empty();
  static bool _simplify = false;

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
      await _setUserName(name);
      await _setInitialSimplify(false);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  static Future<void> singOut() async {
    _userRole = UserRole.unselected;
    _bondCode = '';
    _simplify = false;
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  static Future<void> _setUserName(String name) async {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      try {
        await firebaseUser.updateDisplayName(name);
        await _collectionReferenceUsers.doc(firebaseUser.email).set({
          'name': name,
        });
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
  }

  static Future<void> _setInitialSimplify(bool s) async {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      try {
        await _collectionReferenceUsers.doc(firebaseUser.email).update({
          'simplify': s,
        });
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
  }

  static Future<void> setSimplify(bool s) async {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      if (_userRole == UserRole.careReceiver) {
        try {
          await _collectionReferenceUsers.doc(firebaseUser.email).update({
            'simplify': s,
          });
          Authentication._simplify = s;
        }
        on FirebaseException catch (e) {
          throw (e);
        }
      }
      else if (_userRole == UserRole.caregiver) {
        try {
          await _collectionReferenceUsers.doc(_userBond).update({
            'simplify': s,
          });
          Authentication._simplify = s;
        }
        on FirebaseException catch (e) {
          throw (e);
        }
      }
    }
  }

  static Future<void> setUserRole(UserRole role) async {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      try {
        await _collectionReferenceUsers.doc(firebaseUser.email).update({
          'role': userRoleToString(role),
        });
        _userRole = role;
        if (role == UserRole.careReceiver) {
          await _collectionReferenceUsers.doc(firebaseUser.email).update({
            'bondCode': ToString.randomString(5),
          });
        }
        else {
          await _collectionReferenceUsers.doc(firebaseUser.email).update({
            'bond': 'null',
          });
        }
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
            .doc(firebaseUser.email)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            if (documentSnapshot.data()!['role'].toString() == 'caregiver') {
              Authentication._userRole = UserRole.caregiver;
            } else if (documentSnapshot.data()!['role'].toString() ==
                'careReceiver') {
              Authentication._userRole = UserRole.careReceiver;
              Authentication._bondCode = documentSnapshot.data()!['bondCode'].toString();
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

  static Future<void> loadSimplify() async {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      if (_userRole == UserRole.careReceiver) {
        try {
          await _collectionReferenceUsers
              .doc(firebaseUser.email)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              Authentication._simplify = documentSnapshot.data()!['simplify'];
            }
          });
        }
        on FirebaseException catch (e) {
          throw (e);
        }
      }
      else if (_userRole == UserRole.caregiver) {
        try {
          await _collectionReferenceUsers
              .doc(_userBond)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              Authentication._simplify = documentSnapshot.data()!['simplify'];
            }
          });
        }
        on FirebaseException catch (e) {
          throw (e);
        }
      }
    }
  }

  static Future<void> loadUserBond() async {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      try {
        await _collectionReferenceUsers
            .doc(firebaseUser.email)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            if (_userRole == UserRole.caregiver) {
              if (documentSnapshot.data()!['bond'] != null) {
                _userBond = documentSnapshot.data()!['bond'].toString();
              }
            }
            else if (_userRole == UserRole.careReceiver) {
              if (documentSnapshot.data()!['bond'] != null) {
                _userBonds = List.from(documentSnapshot.data()!['bond']);
              }
            }
          }
        });
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
  }

  static String getUserBond() {
    return _userBond;
  }

  static List<String> getUserBonds() {
    return _userBonds;
  }

  static bool getSimplify() {
    return _simplify;
  }

  static Future<void> bondCurrentUser(String userEmail, String userCode) async {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      try {
        await _collectionReferenceUsers
            .doc(userEmail)
            .get()
            .then((DocumentSnapshot documentSnapshot) async {
          if (documentSnapshot.exists) {
            if (documentSnapshot.data()!['role'].toString() == 'careReceiver') {
              if (documentSnapshot.data()!['bondCode'].toString() == userCode) {
                await _collectionReferenceUsers.doc(firebaseUser.email).update({
                  'bond': userEmail,
                });
                await _collectionReferenceUsers.doc(userEmail).update({
                  "bond": FieldValue.arrayUnion([firebaseUser.email]),
                });
                _userBond = userEmail;
              }
              else {
                throw(FirebaseException);
              }
            }
            else {
              throw(FirebaseException);
            }
          }
        });
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
  }

  static String getUserBondCode() {
    return Authentication._bondCode;
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
      );
    } else {
      return UserModel.empty;
    }
  }

  static String getCurrentUserEmail() {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return firebaseUser.email!;
    }
    else {
      return '';
    }
  }
}
