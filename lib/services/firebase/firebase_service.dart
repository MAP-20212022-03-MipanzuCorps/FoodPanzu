import 'package:firebase_auth/firebase_auth.dart';
// import 'package:foodpanzu/models/user_model.dart';
import 'package:map_mvvm/service_stream.dart';

abstract class firebaseService with ServiceStream {
// ignore_for_file: camel_case_types

  Future<void> forgotPasswordUsingEmail(email);
  Future<void> createAccountWithEmailAndPassword(name, email, password, role);
  Future<void> signInWithEmailAndPassword(email, password);
  User? authStateChanges();
  Future<String> signOut();
  User? getCurrentUser();
  // Future<UserModel?> retrieveUserInfo();
  Future<String> fetchRole();
}
