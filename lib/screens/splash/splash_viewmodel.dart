import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/screens/home/home_screen.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
// import 'package:foodpanzu/services/firebase/firestorage_service.dart';
// import 'package:get/get.dart';
import 'package:map_mvvm/map_mvvm.dart';
import '../owner_home/ownerhome_screen.dart';

class SplashViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;
  // late UserModel _user;
  String role = '';

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;
    // _user = await service.getUser(service.getCurrentUser()!.uid);
      // role = _user.role;
  }

  // updateUserState(currentUser) {
  //   _user = currentUser;
  //   //trasnform _user into
  // }

  bool userHasSignIn() {
    if (service.getCurrentUser() == null) {
      return false;
    } else {
      return true;
    }
  }

  void goToHomePageBasedOnRole(BuildContext context) async {
    // update(() async {
      // _user = await service.getUser(service.getCurrentUser()!.uid);
      // role = _user.role;
      role = await service.fetchRole();
      
    // });
print(role);
    if (role == "owner") {
      //return a owner home page
      Navigator.pushNamed(context, OwnerHomeScreen.routeName);
    } else if(role == "owner") {
      //return a customer home page
      Navigator.pushNamed(context, OwnerHomeScreen.routeName);
    }
  }

  // Future<void> checkUserSignInStatus() async {
  //   await update(
  //     () async {
  //       try {
  //         updateUserState(service.authStateChanges());
  //       } on Failure {
  //         rethrow;
  //       }
  //     },
  //   );
  // }
}
