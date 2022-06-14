import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service_impl.dart';
import 'package:map_mvvm/map_mvvm.dart';

class AddNewMenuViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  StreamSubscription? _streamListener;
  Menu _menu = Menu();
  String menuPath = "menu";

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;
  }

  Menu get menu {
    return _menu;
  }

  Future<void> addNewMenu(Menu menu, String path) async {
    await update(() async {
      _menu = menu;
      try {
        //get the restaurantId
        var user = await service.getUser(service.getCurrentUser()!.uid);

        // add to firebase storage
        await storageService.uploadFile(
            path, menuPath + "/" + user.restId + "/" + menu.foodPicture);
        // add to firestore
        await service.addNewMenu(menu, user.restId!);
      } on FirebaseException catch (e) {}
    });
  }
}
