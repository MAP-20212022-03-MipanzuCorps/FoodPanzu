import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodpanzu/models/menu_model.dart';
// import 'package:foodpanzu/models/user_model.dart';
import 'package:map_mvvm/service_stream.dart';

import '../../models/user_model.dart';

abstract class firebaseService with ServiceStream<QuerySnapshot<Object?>> {
// ignore_for_file: camel_case_types

  Future<void> forgotPasswordUsingEmail(email);
  Future<void> createAccountWithEmailAndPassword(name, email, password, role);
  Future<void> signInWithEmailAndPassword(email, password);
  User? authStateChanges();
  Future<String> signOut();
  User? getCurrentUser();
  // Future<UserModel?> retrieveUserInfo();
  Future<String> fetchRole();
  Future<void> addNewMenu(Menu menu, String restaurantId);
  Future<List<Menu>> getAllMenu(String restaurantId);
  Future<UserModel> getUser(String id);
  Stream<QuerySnapshot<Object?>>? menuListListener();
}
