import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class AddOrderViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  StreamSubscription? _streamListener;

  @override
  void init() async {
    await update(() async {
      super.init();
      notifyListenersOnFailure = true;
    });
  }

  Future<String> getMenuImage(String imageName) {
    return storageService.downloadUrl(imageName);
  }
}
