// ignore_for_file: camel_case_types, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';

class fireBaseServiceImpl extends firebaseService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;
  User get currentUser => _firebaseAuth.currentUser!;

  //forgot password
  @override
  Future<String> forgotPasswordUsingEmail(email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      //return result sucess to forgot password screen
      return "Password Reset Email Sent";
    } on FirebaseAuthException catch (e) {
      print(e);
      //return error back to display screen
      return e.message.toString();
    }
  }

  //Sign up
  @override
  Future<void> createAccountWithEmailAndPassword(name, email, password) async {
    try {
      //create user first
      var _user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      //add user detail to firestore
      await _firebaseFirestore.collection('Users').doc(_user.user!.uid).set({
        'name': name,
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      //return error back to display screen
      // return e.message.toString();
    }
  }

  //Sign in
  @override
  Future<void> signInWithEmailAndPassword(email, password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      //return error back to display screen
      // return e.message.toString();
    }
  }

  @override
  Future<void> roleChosen(role) async {
    try {
      await _firebaseFirestore.collection('Users').doc(currentUser.uid).set(
        {
          'role': role,
        },
        SetOptions(merge: true),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      //return error back to display screen
      // return e.message.toString();
    }
  }

// Sign Out
  @override
  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    return 'Signed Out Successfully';
  }
}
// Fetch User Information
// Future<String> fetchUserInformation() async {
//   try {
//     var snapshot =
//         await _firebaseFirestore.collection('Users').doc(currentUser.uid).get();
//     return snapshot.data()?['name'] as String;
//   } on FirebaseAuthException catch (e) {
//     throw signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!';
//   } catch (e) {
//     throw '${e.toString()} Error Occured!';
//   }
// }


