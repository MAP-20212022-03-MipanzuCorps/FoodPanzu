import 'dart:async';

// import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class HomeViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
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

  Future<void> getRestaurantList() async {
    try {
      restaurantList = await service.getAllRestaurant();
      // for (var restaurant in restaurantList!) {
      //   if (restaurant.restStatus == false) restaurantList!.remove(restaurant);
      // }
    } on Failure {
      rethrow;
    }
  }

  Future<List<Menu>> getMenuList(String restId) async {
    return await service.getAllMenu(restId);
  }
}
