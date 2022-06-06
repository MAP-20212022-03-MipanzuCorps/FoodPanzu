import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/order_model.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

import '../../models/menu_model.dart';

class OwnerOrderViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  StreamSubscription? _streamListener;
  StreamSubscription? _userListener;

  bool get isListeningToStream => _streamListener != null;
  List<Order> _orderList = [];
  UserModel user = UserModel();

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;

    await update(() async {
      //get the restaurantId
      user = await service.getUser(service.getCurrentUser()!.uid);
      service.initializeUser();
      _orderList = await service.getAllOrder(user.restId!);
    });

    _streamListener = service.listen(
      onData: (data) async {
        await update(() async {
          _orderList = [];
          for (var document in data.docs) {
            orderList
                .add(Order.fromJson(document.data() as Map<String, dynamic>));
          }
        });
      },
      onError: (e) {
        catchError(e);
      },
    );

    _userListener = service.authStateChanges().listen((event) async {
      await update(() async {
        if (event != null) {
          user = await service.getUser(event.uid);
          service.initializeUser();
          _orderList = await service.getAllOrder(user.restId!);
          print(user);
        }
      });
    });
  }

  bool hasMenu() {
    return _orderList.isNotEmpty;
  }

  set orderList(orderList) {
    _orderList = orderList;
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

  @override
  void dispose() {
    _streamListener?.cancel();
    _streamListener = null;
    _userListener!.cancel();
    _userListener = null;
    super.dispose();
  }
}
