// ignore_for_file: camel_case_types

import '../../models/user_model.dart';
import 'package:map_mvvm/service_stream.dart';

abstract class firebaseService with ServiceStream{
  Future<void> addUserToFireStore(UserModel userModel);
  Future<String> forgotPasswordUsingEmail(email);
  Future<void> createAccountWithEmailAndPassword(email, password);
}
