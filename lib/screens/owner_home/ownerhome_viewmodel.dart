import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

import '../../models/menu_model.dart';

class OwnerHomeViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  StreamSubscription? _streamListener;

  bool get isListeningToStream => _streamListener != null;
  List<Menu> _menuList = [];
  UserModel user = UserModel();

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;

    await update(() async {
      //get the restaurantId
      user = await service.getUser(service.getCurrentUser()!.uid);
      service.initializeUser();
      _menuList = await service.getAllMenu(user.restId!);
    });

    _streamListener = service.authStateChanges().listen((event) async {
      await update(() async {
        if (event != null) {
          user = await service.getUser(event.uid);
          service.initializeUser();
          _menuList = await service.getAllMenu(user.restId!);
          _streamListener = service.listen(
            onData: (data) async {
              await update(() async {
                _menuList = [];
                for (var document in data.docs) {
                  menuList.add(
                      Menu.fromJson(document.data() as Map<String, dynamic>));
                }
              });
            },
            onError: (e) {
              catchError(e);
            },
          );
        }
      });
    });
  }

  bool hasMenu() {
    return _menuList.isNotEmpty;
  }

  set menuList(menuList) {
    _menuList = menuList;
  }

  List<Menu> get menuList {
    return _menuList;
  }

  bool userAuthenticate() {
    return service.getCurrentUser() != null;
  }

  Future<void> emptyList() async {
    await update(() async {
      _menuList = [];
    });
  }

  Future<String> getMenuImage(String imageName) {
    Future<String> imageUrl;
    imageUrl = storageService.downloadUrl(imageName);
    return imageUrl;
  }

  Future<void> signOut() async => await update(() async {
        await service.signOut();
        _menuList = [];
        user = UserModel();
      });

  Stream<User?> currentUser() {
    return service.authStateChanges();
  }

  @override
  void dispose() {
    _streamListener?.cancel();
    _streamListener = null;

    super.dispose();
  }
}
