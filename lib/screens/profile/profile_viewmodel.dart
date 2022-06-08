// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/screens/logout_success/logout_success_screen.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class ProfileViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;
  String _name = '';
  String _userPic = '';
  var _imageUrl;
  String _filepath = '';
  late UserModel user;

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;

    await update(() async => user = await service.getUser(service.getCurrentUser()!.uid));
    // _streamListener = service.streamUser()!.listen((event) {
    //   user = event as UserModel;
    // });

    _imageUrl = await storageService.downloadUrl(user.userPic);
    _userPic = user.userPic;

    await service.initializeUser();
  }

  set name(value) => update(() async => _name = value);
  set userPic(value) => update(() async => _userPic = value);
  set filepath(value) => update(() async => _filepath = value);
  String get getname => _name;
  String get getuserpic => _userPic;
  get getpic => _imageUrl;
  String get getfilepath => _filepath;

  Future<void> updateProfile() async => await update(() async {
        try {
          await service.editProfile(_name, _userPic);
          await storageService.uploadFile(_filepath, _userPic);
        } on Failure {
          rethrow;
        }
      });

  Future<void> signOut(context) async => await update(() async {
        try {
          await service.signOut();

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LogOutSuccessScreen(),
            ),
            (route) => false,
          );
          Navigator.popUntil(context, (route) => route.isFirst);
        } on Failure {
          rethrow;
        }
      });

  @override
  void dispose() {
    _streamListener?.cancel();
    _streamListener = null;
    super.dispose();
  }
}
