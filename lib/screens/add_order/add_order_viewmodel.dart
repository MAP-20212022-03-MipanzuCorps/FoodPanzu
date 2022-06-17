import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/models/order_item_model.dart';
import 'package:foodpanzu/models/order_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class AddOrderViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  StreamSubscription? _streamListener;
  int quantity = 0;

  @override
  void init() async {
    await update(() async {
      super.init();
      notifyListenersOnFailure = true;
    });
  }

  Future<void> decreaseQuantity() async {
    if (quantity > 0) {
      await update(() async {
        quantity--;
      });
    }
  }

  Future<void> increaseQuantity() async {
    await update(() async {
      quantity++;
    });
  }

  Future<String> getMenuImage(String imageName) {
    return storageService.downloadUrl(imageName);
  }

  addIntoCart(Menu menu) async {
    //All logic write below to ensure that customer can only add order of a menu from the same restaurant only!!
    Order? cart;
    OrderItem? newOrderItems;

    List<Order> orderList =
        await service.getAllCustOrder(service.getCurrentUser()!.uid);
    if (orderList.isNotEmpty) {
      for (var order in orderList) {
        //order status with status "cart" means the order is still pending, not yet confirmed by the customer.
        //only once paid, the status will change to cooking to indicate that the order is being prepared.
        if (order.orderStatus == "cart") {
          cart = order;
        }
      }
    }
    //check the customer cart, if the menu is from the same restaurant, create a new order item and add it into cart
    if (cart != null) {
      if (cart.restId != menu.restId) {
        //if menu is from different restaurant, then clear the orderItem in database from the current cart
        //also delete orderItem from cart too
        if (cart.orderItems != null) {
          for (String orderItem in cart.orderItems!) {
            service.deleteOrderItem(orderItem);
          }
        }
        cart.orderItems = [];
        //After that,update the restaurantId in the cart and add order item into it
        cart.restId = menu.restId;
        cart.totalPrice = 0;
      }
    } else {
      //if cart is null, then create a new customer cart
      cart = Order(
          restId: menu.restId,
          userId: service.getCurrentUser()!.uid,
          //table number will be fixed later when QR code feature is alive, for now it is hardcoded
          tableNumber: "1",
          orderStatus: "cart");

      String orderId = await service.createOrder(cart);
      cart.orderId = orderId;
    }
    newOrderItems = (OrderItem(
        menuId: menu.menuId, quantity: quantity, orderId: cart.orderId));
    double totalPrice = cart.totalPrice;
    //update the new orderId and total price in the cart
    String newOrderItemId = await service.addOrderItem(newOrderItems);
    if (cart.orderItems != null) {
      cart.orderItems!.add(newOrderItemId);
    } else {
      cart.orderItems = [newOrderItemId];
    }
    // List<String> orderItems = cart.orderItems;
    // orderItems.add(newOrderItemId);
    // cart.orderItems = orderItems;
    cart.totalPrice = totalPrice + menu.foodPrice * quantity;

    //update cart in the database
    service.updateOrder(cart);
  }
}
