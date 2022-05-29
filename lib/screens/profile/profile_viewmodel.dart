// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/screens/logout_success/logout_success_screen.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class ProfileViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;
  // dynamic _restId = '';
  // String _ssmNumber = '';
  // String _restName = '';
  // String _restDesc = '';
  // String _restAddress = '';
  // String _restZipCode = '';

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  // set ssmNumber(value) => update(() async => _ssmNumber = value);
  // set restName(value) => update(() async => _restName = value);
  // set restDesc(value) => update(() async => _restDesc = value);
  // set restAddress(value) => update(() async => _restAddress = value);
  // set restZipCode(value) => update(() async => _restZipCode = value);
  // String get getssm => _ssmNumber;
  // String get getrestname => _restName;
  // String get getdesc => _restDesc;
  // String get getaddress => _restAddress;
  // String get getzipcode => _restZipCode;

  Future<void> signOut(context) async => await update(() async {
        try {
          await service.signOut();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LogOutSuccessScreen(),
            ),
            (route) => false,
          );
          Navigator.popUntil(context, (route) => route.isFirst);
        } on Failure {
          rethrow;
        }
      });
}
