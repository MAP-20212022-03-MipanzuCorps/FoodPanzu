import 'dart:async';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/models/order_item_model.dart';
import 'package:foodpanzu/models/order_model.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class OwnerViewOrderViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  StreamSubscription? _streamListener;
  UserModel user = UserModel();

  List<OrderItem> _orderItems = [];
  List<Menu> _menuList = [];
  late Order order;
  String name = "";
  Order? cart;

  late OrderItem orderItem;
  List<OrderItem> newOrderItem = [];

  List<Menu> get menuList => _menuList;

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;
  }

  bool hasOrderItems() {
    return order.orderItems?.isNotEmpty ?? false;
  }

  Future<List<Menu>> set() async {
    for (var orderItemId in order.orderItems!) {
      orderItem = await service.getOrderItem(orderItemId);
      menuList.add(await service.getMenu(orderItem.menuId));
      newOrderItem.add(orderItem);
      print("\nmenu id :" + orderItem.menuId);
      print("\nmenu name :" + menuList.first.foodName);
    }
    _menuList = menuList;
    _orderItems = newOrderItem;

    return _menuList;
  }

  bool hasOrder() {
    return order != null;
  }

  List<OrderItem> get orderItems {
    return _orderItems;
  }

  void setOrder(oid) async {
    await update(() async {
      _menuList = [];
      order = await service.getOrder(oid);
    });
  }

  Future<String> getMenuImage(int index) async {
    Future<String> imageUrl;
    imageUrl = storageService.downloadUrl(menuList[index].foodPicture);
    return imageUrl;
  }
}
