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
  List<Order> _orders = [];
  

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
 String get monthlySales {
    double _monthlySales = 0;
    _orders.forEach((element) {
      _monthlySales += element.totalPrice;
    });
    return _monthlySales.toStringAsFixed(2);
  }

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

  Future<void> getMonthlySales(DateTime selected) async {
    await update(() async {
      _orders = [];
      _orders = await service.getAllOrderByMonth(_user.restId, selected);
      print(_orders.length);
    });
  }

  Future<void> openClose() async => await update(() async {
        try {
          await service.openClose(_restStatus);
        } on Failure {
          rethrow;
        }
      });
}
