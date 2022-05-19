import 'dart:async';
// import 'package:foodpanzu/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class SplashViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;
  User? _user;

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  updateUserState(event) {
    _user = event;
  }

  bool userHasSignIn() {
    _user = service.getCurrentUser();
    if (_user == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> checkUserSignInStatus() async {
    await update(
      () async {
        try {
          updateUserState(service.authStateChanges());
        } on Failure catch (e) {
          rethrow;
        }
      },
    );
  }
}
