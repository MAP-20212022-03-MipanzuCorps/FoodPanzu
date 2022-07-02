import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/models/order_item_model.dart';
import 'package:foodpanzu/models/order_model.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/email/mail_builder.dart';
import 'package:foodpanzu/services/email/mail_services.dart';
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
    _menuList = [];
    _orderItems = [];
    newOrderItem = [];
    for (var orderItemId in order.orderItems!) {
      orderItem = await service.getOrderItem(orderItemId);
      menuList.add(await service.getMenu(orderItem.menuId));
      newOrderItem.add(orderItem);
      // print("\nmenu id :" + orderItem.menuId);
      // print("\nmenu name :" + menuList.first.foodName);
    }

    _menuList = menuList;
    _orderItems = newOrderItem;
    print(_orderItems.length);

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

  void changeOrderStatus() {
    if (order != null) {
      update(() async {
        order.orderStatus = "Completed";
        order.orderDate = DateTime.now();
        print("completed :" +order.orderId);
        await service.updateOrder(order);
      });
    }
  }

  Future<void> sendInvoice() async {
    UserModel customer = await service.getUser(order.userId);
    Restaurant restaurant = await service.getRestaurant(order.restId);
    String message = orderInvoiceMailBuilder(
        order: order,
        orderItems: _orderItems,
        menuList: _menuList,
        restaurant: restaurant);
    //assuming the email given is correct or else, the system not send the email
    //The system however, will not show the message to the user
    await invoiceMail(
        receivingName: customer.name,
        receivingEmail: customer.email,
        message: message);
  }
}
