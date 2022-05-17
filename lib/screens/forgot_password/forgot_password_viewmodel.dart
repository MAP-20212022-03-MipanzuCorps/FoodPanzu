import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/services/service.dart';
import 'package:map_mvvm/failure.dart';
import 'package:map_mvvm/viewmodel.dart';

class forgotPasswordModel extends Viewmodel {
  //service
  firebaseService get _firebaseService => locator<firebaseService>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;
  String email = '';
  String status = '';

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  String get _email => email;
  set _email(value) => update(() async => email = value);
  String get _status => status;
  set _status(value) => update(() async => status = value);
  Future<void> forgotPassword(email) async {
    try {
      await update(() async {
        await _firebaseService.forgotPasswordUsingEmail(email);

        status = "done";
      });
    } on Failure {
      rethrow;
    }
  }
}
