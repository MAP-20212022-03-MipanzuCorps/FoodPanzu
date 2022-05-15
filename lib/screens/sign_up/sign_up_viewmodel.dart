import 'dart:async';
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
  String name = '';

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  Future<void> createAccountWithEmailAndPassword(name, email, password) async =>

      await update(() async {
        await service.createAccountWithEmailAndPassword(name, email, password);
      });
}
