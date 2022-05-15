import 'dart:async';

import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class RoleChoiceViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;
  String role = '';

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  Future<void> roleChosen(role) async =>
      await update(() async {
        await service.roleChosen(role);
      });
}
