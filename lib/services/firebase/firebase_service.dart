import '../../models/user_model.dart';
import 'package:map_mvvm/service_stream.dart';

abstract class firebaseService with ServiceStream {
// ignore_for_file: camel_case_types

  Future<String> forgotPasswordUsingEmail(email);
  Future<void> createAccountWithEmailAndPassword(name, email, password);
  Future<void> signInWithEmailAndPassword(email, password);
  Future<void> roleChosen(role);
  Future<String> signOut();
}
