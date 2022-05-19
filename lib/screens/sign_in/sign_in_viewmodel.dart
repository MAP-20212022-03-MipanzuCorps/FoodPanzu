import 'dart:async';
// import 'package:foodpanzu/screens/home/home_screen.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class SignInViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;
  String email = '';
  String password = '';
  String _role = '';

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  String get getrole => _role;

  Future<void> signIn(email, password) async => await update(() async {
        try {
          await service.signInWithEmailAndPassword(email, password);
          _role = await service.fetchRole();
        } on Failure {
          rethrow;
        }
      });
}
