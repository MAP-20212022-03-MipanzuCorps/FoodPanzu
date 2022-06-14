import 'dart:async';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

import '../../models/menu_model.dart';

class RestaurantMenuViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  StreamSubscription? _streamListener;

  bool get isListeningToStream => _streamListener != null;

  List<Menu> _menuList = [];
  UserModel user = UserModel();
  late Restaurant restaurant;

  void setrestaurant(Restaurant newRest) {
    restaurant = newRest;
  }
 
  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;

    await update(() async {
      user = await service.getUser(service.getCurrentUser()!.uid);
      service.initializeUser();
    });

  }

  bool hasMenu() {
    return _menuList.isNotEmpty;
  }

  List<Menu> get menuList {
    return _menuList;
  }

  Future<void> getRestaurantMenu(restId) async{
    _menuList = await service.getAllMenu(restId);
  }

  Future<String> getMenuImage(String imageName) {
    Future<String> imageUrl;
    imageUrl = storageService.downloadUrl(imageName);
    return imageUrl;
  }
}
