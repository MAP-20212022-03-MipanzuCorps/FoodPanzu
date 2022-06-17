import 'dart:async';

// import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/screens/restaurant_menu/restaurantmenu_viewmodel.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class HomeViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  RestaurantMenuViewModel get menuviewmodel =>
      locator<RestaurantMenuViewModel>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;

  List<Restaurant>? restaurantList;

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;

    await update(() async => restaurantList = await service.getAllRestaurant());
    // for (var restaurant in restaurantList!) {
    //   if (restaurant.restStatus == false) restaurantList!.remove(restaurant);
    // }
  }

  void setRestaurant(restId) {
    menuviewmodel.setRestaurant(restId);
  }

  Future<void> getRestaurantList() async {
    await update(() async => restaurantList = await service.getAllRestaurant());

    // for (var restaurant in restaurantList!) {
    //   if (restaurant.restStatus == false) restaurantList!.remove(restaurant);
    // }
  }
}
