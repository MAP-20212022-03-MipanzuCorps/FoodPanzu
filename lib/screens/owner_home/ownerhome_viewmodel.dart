import 'dart:async';
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

      _menuList = await service.getAllMenu(user.restId!);
      service.initializeUser();
    });

    _streamListener = service.listen(
      onDone: dispose,
      onData: (data) async {
        await update(() async {
          _menuList = [];
          for (var document in data.docs) {
            _menuList.add(Menu.fromJson(document.data()));
          }
        });
      },
      onError: (e) {
        catchError(e);
      },
    );
  }

  bool hasMenu() {
    return _menuList != null;
  }

  set menuList(menuList) {
    _menuList = menuList;
  }

  updateMenu(menuList) async {
    await update(() async {
      _menuList = menuList;
    });
  }

  List<Menu>? get menuList {
    return _menuList;
  }

  // Future<List<Menu>?> getMenu() async {
  //   //get the restaurantId
  //   await update(() async {
  //     var usert = await service.getUser(service.getCurrentUser()!.uid);
  //   _menuList = await service.getAllMenu(user!.restId!);
  //   });
  //   print(_menuList);
  // }

  Future<String> getMenuImage(String imageName) {
    Future<String> imageUrl;
    imageUrl = storageService.downloadUrl(imageName);
    return imageUrl;
  }

  // Stream<List<Menu>>? menuUpdateListener() {
  //   return service.menuListListener();
  // }

  Future<void> signOut() async => await update(() async {
        await service.signOut();
      });
}
