import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/order_model.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class CustOrderViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  StreamSubscription? _streamListener;

  bool get isListeningToStream => _streamListener != null;
  List<Order> _orderList = [];
  List<Order> _orderHisList = [];
  UserModel user = UserModel();
  UserModel custId = UserModel();
  String id="";
  String name="";
  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;
    //await update(() async => orderLists = await service.getAllOrder());
    await update(() async {
      user = await service.getUser(service.getCurrentUser()!.uid);
      id = user.userId;
      _orderList = await service.getAllCustOrder(user.userId);
      _orderHisList = await service.getAllCustOrderHistory(user.userId);
    });
  }

  String getId() {
    print("this is id "+id);
    return id;
  }

  Future<void> getOrder(String uid) async {
    try {
      _orderList = await service.getAllCustOrder(uid);
    } on Failure {
      rethrow;
    }
  }

  Future<void> getOrderHis(String uid) async {
    try {
      _orderHisList = await service.getAllCustOrderHistory(uid);
    } on Failure {
      rethrow;
    }
  }

  bool hasOrder() {
    return _orderList.isNotEmpty;
  }
  bool hasOrderHis() {
    return _orderHisList.isNotEmpty;
  }



  List<Order> get orderList {
    return _orderList;
  }

  List<Order> get orderHisList {
    return _orderHisList;
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
