// ignore_for_file: unused_element

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/screens/home/home_screen.dart';
import 'package:foodpanzu/screens/owner_home/ownerhome_screen.dart';
import 'package:foodpanzu/screens/restaurant_sign_up/restaurant_signup_screen.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class SignInViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;
  String email = '';
  String password = '';
  late UserModel currUser;

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  Future<void> signIn(email, password) async => await update(() async {
        try {
          currUser = await service.signInWithEmailAndPassword(email, password);
        } on Failure {
          rethrow;
        }
      });

  void navigator(BuildContext context) {
    if (currUser.role == "customer") {
      Navigator.popAndPushNamed(context, HomeScreen.routeName);
    } else {
      if (currUser.restId == '') {
        Navigator.popAndPushNamed(context, RestaurantSignUpScreen.routeName);
      } else {
        Navigator.popAndPushNamed(context, OwnerHomeScreen.routeName);
      }
    }
  }
}
