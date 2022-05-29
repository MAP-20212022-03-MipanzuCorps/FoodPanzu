import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:map_mvvm/service_stream.dart';

abstract class firebaseService with ServiceStream {

// abstract class firebaseService with ServiceStream {
// ignore_for_file: camel_case_types

  Future<void> forgotPasswordUsingEmail(email);
  Future<void> createAccountWithEmailAndPassword(name, email, password, role);
  Future<UserModel?> signInWithEmailAndPassword(email, password);
  User? authStateChanges();
  Future<String> signOut();
  User? getCurrentUser();
  Future<String> fetchRole();
  Future<void> signUpRestaurant(Restaurant restaurant);
  Future<void> addNewMenu(Menu menu, String restaurantId);
  Future<List<Menu>> getAllMenu(String restaurantId);
  Future<UserModel> getUser(String id);
  Stream? menuListListener();
  Future<void> initializeUser();
  Future<void> deleteMenu(String menuId);
}
