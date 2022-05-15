import 'dart:async';

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
  String msg = '';
  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  String get _msg => msg;
  set _msg(value) => update(() async {
        return msg = value;
      });
  String get _email => email;
  set _email(value) => update(() async => email = value);

  forgotPasswordUsingEmail(email) {
    update(() async {
      msg = await _firebaseService.forgotPasswordUsingEmail(email);
    });
  }
}
