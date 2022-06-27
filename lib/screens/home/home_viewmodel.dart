import 'dart:async';

// import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/screens/restaurant_menu/restaurantmenu_viewmodel.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class HomeViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  RestaurantMenuViewModel get menuviewmodel =>
      locator<RestaurantMenuViewModel>();
  List<Restaurant>? _restaurantList;
  dynamic _imageUrl;
  List<Menu> _menuList = [];

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;

    await update(() async => _restaurantList = await service.getAllRestaurant());
  }

    bool hasMenu() {
    return _menuList.isNotEmpty;
  }

  List<Menu> get menuList => _menuList;

  get getpic => _imageUrl;
  List<Restaurant>? get restaurantList => _restaurantList;

  bool hasRestaurant() => restaurantList!.isNotEmpty;

  void setRestaurant(restId) {
    menuviewmodel.setRestaurant(restId);
  }

  Future<void> refreshPage() async {
    await update(() async {
    _restaurantList = await service.getAllRestaurant();
    _menuList = await service.getAllMenu();

    } )
;  }

  Future<List<Restaurant>> getRestaurantList() async {
    return _restaurantList = await service.getAllRestaurant();
  }

    Future<String> getMenuImage(String imageName) {
    Future<String> imageUrl;
    imageUrl = storageService.downloadUrl(imageName);
    return imageUrl;
  }

  Future<List<Menu>> getMenuList() async {
    return _menuList = await service.getAllMenu();
  }

  Future<dynamic> getRestaurantPicture(String imageName) async {
    if (imageName == '') return _imageUrl = null;
    _imageUrl = await storageService.downloadUrl(imageName);
    return _imageUrl;
  }
}
