// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields

import 'dart:async';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/order_model.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class DashboardViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;
  bool _restStatus = false;
  late Restaurant _restaurant;
  UserModel _user = UserModel();

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;
    await update(() async {
      _user = (await service.getUser(service.getCurrentUser()!.uid)).copyWith();
      // _restaurant = await service.getRestaurant(_user.restId);
    });
  }

  String get restId => _restaurant.restId;
  String get restName => _restaurant.restName;

  set restStatus(value) => update(() async => _restStatus = value);
  bool get getStatus => _restStatus;
  String get getStats {
    if (_restStatus == false) {
      return 'Closed';
    } else {
      return 'Open';
    }
  }

  Future<Restaurant> getRestaurant() async {
    _user = (await service.getUser(service.getCurrentUser()!.uid)).copyWith();
    _restaurant = await service.getRestaurant(_user.restId);
    _restStatus = _restaurant.restStatus;
    print(_user.restId);
    return _restaurant;
  }

  Future<void> openClose() async => await update(() async {
        try {
          await service.openClose(_restStatus);
        } on Failure {
          rethrow;
        }
      });
}
