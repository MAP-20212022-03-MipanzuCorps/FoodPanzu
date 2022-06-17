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

    //order status with status "cart" means the order is still pending, not yet confirmed by the customer.
    //only once paid, the status will change to cooking to indicate that the order is being prepared.
    cart = await service.getPendingOrder(service.getCurrentUser()!.uid);

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
          orderStatus: "cart",
          orderItems: []);

      String orderId = await service.createOrder(cart);
      cart.orderId = orderId;
    }
    newOrderItems = (OrderItem(
        menuId: menu.menuId, quantity: quantity, orderId: cart.orderId));
    double totalPrice = cart.totalPrice;
    bool sameMenu = false;

    if (cart.orderItems != null) {
      //if the added menu is already in the cart, then just increase the quantity and update the price
      for (String orderItemId in cart.orderItems!) {
        OrderItem orderItem = await service.getOrderItem(orderItemId);
        if (orderItem.menuId == menu.menuId) {
          orderItem.quantity += quantity;
          await service.updateOrderItem(orderItem);
          // totalPrice += menu.foodPrice * quantity;
          // cart!.totalPrice = totalPrice;
          // await service.updateOrder(cart);
          sameMenu = true;
          break;
        }
      }

      if (sameMenu == false) {
        //if the added menu is not in the cart, then add it into the cart
        //update the new orderId in the cart
        String newOrderItemId = await service.addOrderItem(newOrderItems);
        cart.orderItems!.add(newOrderItemId);
      }
    } else {
      //update the new orderId and total price in the cart
      String newOrderItemId = await service.addOrderItem(newOrderItems);
      cart.orderItems = [newOrderItemId];
    }
    cart.totalPrice = totalPrice + menu.foodPrice * quantity;

    //update cart in the database
    service.updateOrder(cart);
  }

  @override
  void dispose() {
    _streamListener?.cancel();
    super.dispose();
  }
}
