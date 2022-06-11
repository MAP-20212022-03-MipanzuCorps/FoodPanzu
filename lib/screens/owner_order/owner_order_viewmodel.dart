import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/order_model.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class OwnerOrderViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  StreamSubscription? _streamListener;
  StreamSubscription? _userListener;

  bool get isListeningToStream => _streamListener != null;
  List<Order> _orderList = [];
  List<Order>? orderLists;
  UserModel user = UserModel();
  UserModel resId = UserModel();
  String res="";
  String name="";
  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;
    //await update(() async => orderLists = await service.getAllOrder());
    await update(() async {
      user = await service.getUser(service.getCurrentUser()!.uid);
      res = user.restId;
      service.initializeUser();
      _orderList = await service.getAllOrder(user.restId);
      orderLists = await service.getAllOrder(user.restId);
    });
  }

  String getRes() {
    return res;
  }

  Future<void> getOrder(String resId) async {
    try {
      _orderList = await service.getAllOrder(resId);
    } on Failure {
      rethrow;
    }
  }

  bool hasMenu() {
    return orderList.isNotEmpty;
  }

  set orderList(orderList) {
    orderLists = orderList;
  }

  List<Order> get orderList {
    return _orderList;
  }

  bool userAuthenticate() {
    return service.getCurrentUser() != null;
  }

  Future<void> emptyList() async {
    await update(() async {
      _orderList = [];
    });
  }

  Future<void> signOut() async => await update(() async {
        await service.signOut();
        _orderList = [];
        user = UserModel();
      });

  Stream<User?> currentUser() {
    return service.authStateChanges();
  }
}
