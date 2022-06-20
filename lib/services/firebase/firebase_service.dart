import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodpanzu/models/order_item_model.dart';
import 'package:foodpanzu/models/order_model.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:map_mvvm/service_stream.dart';

abstract class firebaseService with ServiceStream {
// abstract class firebaseService with ServiceStream {
// ignore_for_file: camel_case_types

//user services
  Future<void> forgotPasswordUsingEmail(email);
  Future<void> createAccountWithEmailAndPassword(name, email, password, role);
  Future<UserModel?> signInWithEmailAndPassword(email, password);
  Stream<User?> authStateChanges();
  Future<String> signOut();
  User? getCurrentUser();
  Future<void> initializeUser();
  Stream? streamUser();
  Future<void> editProfile(name, userPic);
  Future<UserModel> getUser(String id);

//restaurant services
  Future<String> signUpRestaurant(Restaurant restaurant);
  Future<Restaurant> getRestaurant(restId);
  Future<List<Restaurant>> getAllRestaurant();
  Future<void> openClose(restStatus);

//menu services
  Future<void> addNewMenu(Menu menu, String restaurantId);
  Future<void> editMenu(Menu menu, String restaurantId);
  Future<List<Menu>> getAllMenu(String restaurantId);
  Stream? menuListListener();
  Future<void> deleteMenu(String menuId);
  Future<Menu> getMenu(String menuId);

//order services
  Future<Order> getOrder(String orderId);
  Future<List<Order>> getAllOrder(String restaurantId);
  Future<List<Order>> getAllOrderHistory(String restaurantId);
  Future<List<Order>> getAllCustOrder(String userId);
  Future<Order?> getPendingOrder(String userId);
  Future<String> addOrderItem(OrderItem orderItem);
  Future<void> deleteOrderItem(String orderItemId);
  Future<OrderItem> getOrderItem(String orderItemId);
  Future<void> updateOrderItem(OrderItem orderItem);
  Future<void> updateOrder(Order order);
  Future<String> createOrder(Order order);
  Future<List<Order>> getAllCustOrderHistory(String restaurantId);
  Stream<QuerySnapshot<Map<String, dynamic>>> orderListListener(String userId);
}
