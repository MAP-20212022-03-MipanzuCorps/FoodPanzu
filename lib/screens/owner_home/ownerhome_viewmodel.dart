import 'dart:async';

// import 'package:foodpanzu/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service_impl.dart';
import 'package:map_mvvm/map_mvvm.dart';

import '../../models/menu_model.dart';

class OwnerHomeViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;
  List<Menu>? _menuList;
  UserModel? user;

  bool hasMenu() {
    return _menuList != null;
  }

  set menuList(menuList) {
    _menuList = menuList;
  }

  List<Menu>? get menuList {
    return _menuList;
  }

  // List<Menu> trasnformDataToList(Map<String, dynamic> map) {
  //   List<Menu> menuList = [];
  //   map.forEach((element) {
  //     menuList.add(Menu.fromJson(element));
  //   });
  //   return menuList;
  // }

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;

    await update(() async {
      try {
        //get the restaurantId
        var user = await service.getUser(service.getCurrentUser()!.uid);

        _menuList = await service.getAllMenu(user.restId!);
      } catch (e) {
        //throw something la
      }
    });

    _streamListener = service.listen(
      onData: (data) async {
        await update(() async {
          Menu menu = (data as Menu);
          if (!_menuList!.contains(menu)) {
            menuList!.add(menu);
          }
        });
      },
      onError: (e) {
        catchError(e);
      },
    );
  }

  Future<List<Menu>?> getMenu() async {
    //get the restaurantId
    var usert = await service.getUser(service.getCurrentUser()!.uid);

    _menuList = await service.getAllMenu(user!.restId!);
    print(_menuList);
  }

  Future<String> getMenuImage(String imageName) {
    Future<String> imageUrl;
    imageUrl = storageService.downloadUrl(imageName);
    return imageUrl;
  }

  Future<void> signOut() async => await update(() async {
        await service.signOut();
      });
}
