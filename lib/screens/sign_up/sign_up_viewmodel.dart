// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodpanzu/app/service_locator.dart';
// import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class SignUpViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;
  String _email = '';
  String _password = '';
  String _name = '';
  String _role = '';

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  set name(value) => update(() async => _name = value);
  set email(value) => update(() async => _email = value);
  set password(value) => update(() async => _password = value);
  set role(value) => update(() async => _role = value);
  String get getname => _name;
  String get getemail => _email;
  String get getpassword => _password;
  String get getrole => _role;

  Future<void> register() async => await update(() async {
        try {
          await service.createAccountWithEmailAndPassword(
              _name, _email, _password, _role);
        } on Failure {
          rethrow;
        }
      });
}
