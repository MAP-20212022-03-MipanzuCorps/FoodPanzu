import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/models/order_item_model.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service_impl.dart';
import 'package:map_mvvm/map_mvvm.dart';

import '../../models/order_model.dart';

class CartViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  StreamSubscription? _streamListener;
  Order? cart;

  bool hasOrderItem() {
    return cart?.orderItems?.isNotEmpty ?? false;
  }

  bool hasOrder() {
    return cart != null;
  }

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;
  }
}
