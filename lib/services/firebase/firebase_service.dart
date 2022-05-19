import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_mvvm/failure.dart';

import '../../models/user_model.dart';
import 'package:map_mvvm/service_stream.dart';

abstract class firebaseService with ServiceStream {
// ignore_for_file: camel_case_types

  Future<void> forgotPasswordUsingEmail(email);
  Future<void> createAccountWithEmailAndPassword(name, email, password);
  Future<void> signInWithEmailAndPassword(email, password);
  User? authStateChanges();
  Future<void> roleChosen(role);
  Future<String> signOut();
  User? getCurremtUser();
}
