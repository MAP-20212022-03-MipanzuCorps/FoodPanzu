import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/models/order_item_model.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service_impl.dart';
import 'package:foodpanzu/utils/enums.dart';
import 'package:map_mvvm/map_mvvm.dart';

import '../../models/order_model.dart';

class CartViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  StreamSubscription? _streamListener;
  Order? cart;
  List<OrderItem>? _orderItems;
  List<Menu> _menuList = [];

  List<OrderItem>? get orderItems {
    return _orderItems;
  }

  List<Menu> get menuList {
    return _menuList;
  }

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
    _streamListener = service
        .orderListListener(service.getCurrentUser()!.uid)
        .listen((order) async {
      if (order.docs.isNotEmpty) {
        await update(() async {
          //listen to the order that has been made by the user
          cart = Order.fromJson(order.docs.first.data());
          //if there is exist order, get the order items and menuList (to fill up the info at the screen)
          if (cart!.orderItems != null) {
            List<OrderItem> newOrderItem = [];
            List<Menu> menuList = [];
            for (var orderItemId in cart!.orderItems!) {
              //this loop already make sure that the index of menuList and orderItem is always the same
              OrderItem orderItem = await service.getOrderItem(orderItemId);
              menuList.add(await service.getMenu(orderItem.menuId));
              newOrderItem.add(orderItem);
            }
            _orderItems = newOrderItem;
            _menuList = menuList;
          }
        });
      } else {
        await update(() async {
          cart = null;
          _orderItems = null;
        });
      }
    });
  }

  Future<String> getMenuImage(int index) async {
    Future<String> imageUrl;
    imageUrl = storageService.downloadUrl(menuList[index].foodPicture);
    return imageUrl;
  }

  Future<void> increaseQuantity(int index) async {
    await update(() async {
      OrderItem orderItem = _orderItems![index];
      int prevQuantity = orderItem.quantity;
      orderItem.quantity++;
      //update the quantity in the database
      await service.updateOrderItem(orderItem);
      //update total price for order in the database
      Menu menu = await service.getMenu(orderItem.menuId);
      cart!.totalPrice = cart!.totalPrice +
          ((orderItem.quantity - prevQuantity) * menu.foodPrice * 1.06);
      await service.updateOrder(cart!);
    });
  }

  Future<void> decreaseQuantity(int index) async {
    OrderItem orderItem = _orderItems![index];
    //only allow update if quantity is greater than 1
    if (orderItem.quantity > 1) {
      await update(() async {
        int prevQuantity = orderItem.quantity;
        orderItem.quantity--;
        //update the quantity in the database
        //update total price for order in the database
        Menu menu = await service.getMenu(orderItem.menuId);
        //1.06 indicate 6% taxed being charged to customer
        cart!.totalPrice = cart!.totalPrice -
            ((prevQuantity - orderItem.quantity) * menu.foodPrice * 1.06);
        await service.updateOrder(cart!);
        await service.updateOrderItem(orderItem);
      });
    }
  }

  Future<void> removeOrderItem(int index) async {
    await update(() async {
      OrderItem orderItem = _orderItems![index];
      _orderItems!.removeAt(index);
      await service.deleteOrderItem(orderItem.orderItemId);
      //update cart in the databsae
      // if (cart!.orderItems != null) {
      cart!.orderItems!.remove(orderItem.orderItemId);
      cart!.totalPrice = cart!.totalPrice -
          (menuList[index].foodPrice * orderItem.quantity * 1.06);
      menuList.removeAt(index);
      await service.updateOrder(cart!);
      // }
    });
  }

  void applyTableNumber(String tableNumber) {
    if (cart != null) {
      update(() async {
        cart!.tableNumber = tableNumber;
        await service.updateOrder(cart!);
      });
    }
  }

  double getSubTotalItem() {
    double subTotal = 0;
    orderItems!.forEach((orderItem) {
      subTotal += orderItem.quantity *
          menuList[orderItems!.indexOf(orderItem)].foodPrice;
    });
    return subTotal;
  }

  void changeOrderStatus() {
    if (cart != null) {
      update(() async {
        cart!.orderStatus = "Cooking";
        await service.updateOrder(cart!);
      });
    }
  }

  @override
  void dispose() {
    _streamListener?.cancel();
    _streamListener = null;
    super.dispose();
  }
}
