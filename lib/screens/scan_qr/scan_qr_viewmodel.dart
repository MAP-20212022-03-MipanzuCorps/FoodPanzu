import 'dart:async';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/screens/restaurant_menu/restaurantmenu_viewmodel.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class ScanQRViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  RestaurantMenuViewModel get menuviewmodel =>
      locator<RestaurantMenuViewModel>();
  @override

  void setRestaurant(restId) {
    menuviewmodel.setRestaurant(restId);
  }
  

}

