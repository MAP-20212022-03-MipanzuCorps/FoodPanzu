// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields

import 'dart:async';
import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class RestaurantViewModel extends Viewmodel {
  firebaseService get service => locator<firebaseService>();
  FireStorage get storageService => locator<FireStorage>();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;
  dynamic _restId = '';
  String _ssmNumber = '';
  String _restName = '';
  String _restDesc = '';
  String _restAddress = '';
  String _restZipCode = '';
  String _restPicture = '';
  String _filepath = '';

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = false;
  }

  set ssmNumber(value) => update(() async => _ssmNumber = value);
  set restName(value) => update(() async => _restName = value);
  set restDesc(value) => update(() async => _restDesc = value);
  set restAddress(value) => update(() async => _restAddress = value);
  set restZipCode(value) => update(() async => _restZipCode = value);
  set restPicture(value) => update(() async => _restPicture = value);
  set filepath(value) => update(() async => _filepath = value);
  String get getssm => _ssmNumber;
  String get getrestname => _restName;
  String get getdesc => _restDesc;
  String get getaddress => _restAddress;
  String get getzipcode => _restZipCode;
  String get getrestpic => _restPicture;
  String get getfilepath => _filepath;

  Future<void> registerRestaurant() async => await update(() async {
        Restaurant restaurant = Restaurant(_restId, _ssmNumber, _restName,
            _restAddress, _restZipCode, _restDesc, '', _restPicture, false);
        // print(restaurant.toJson());
        try {
          _restId = await service.signUpRestaurant(restaurant);
          await storageService.uploadFile(_filepath, "restaurant/"+_restId +"/"+_restPicture);
        } on Failure {
          rethrow;
        }
      });
}
