import 'dart:async';
import 'dart:math';
// import 'package:foodpanzu/screens/home/home_screen.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class SignInViewModel extends Viewmodel {
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

  Future<void> signInWithEmailAndPassword(email, password) async {
    try {
      await update(() async {
        await service.signInWithEmailAndPassword(email, password);
      });
      
    } on Failure {
      rethrow;
    }
  }
}
