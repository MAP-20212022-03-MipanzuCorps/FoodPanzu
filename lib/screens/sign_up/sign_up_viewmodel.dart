// import 'package:foodpanzu/screens/home/home_screen.dart';
// import 'package:foodpanzu/services/firestore_user.dart';
// import 'package:foodpanzu/models/user_model.dart';
// // import 'package:foodpanzu/screens/.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:get/get.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
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
  String email = '';
  String password = '';

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  String get _email => email;
  String get _password => password;
  set _email(value) => update(() async => email = value);
  set _password(value) => update(() async => password = value);

 Future<void> createAccountWithEmailAndPassword(_email, _password) async => 
 await update(() async {
   await service.createAccountWithEmailAndPassword(_email, _password);
 });
}
