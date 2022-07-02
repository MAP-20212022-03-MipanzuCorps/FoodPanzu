// ignore_for_file: camel_case_types, no_leading_underscores_for_local_identifiers, avoid_print, unused_catch_clause

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodpanzu/app/app.dart';
import 'package:foodpanzu/models/order_item_model.dart';
import 'package:foodpanzu/models/order_model.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:map_mvvm/failure.dart';

class fireBaseServiceImpl extends firebaseService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;
  User get currentUser => _firebaseAuth.currentUser!;
  static UserModel user = UserModel();
  String restaurantId = '';

  //forgot password
  @override
  Future<void> forgotPasswordUsingEmail(email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      Failure errorMsg;
      //error handling based on the firebase documentation
      //using custom Failure class to format the error into custom error.
      if (e.code == "invalid-email") {
        errorMsg = Failure(e.code,
            message:
                "Email is not properly formated, please insert an email with correct format",
            location: "firebase_service_impl.dart");
      } else if (e.code == "user-not-found") {
        errorMsg = Failure(e.code,
            message: "There is no user exist for the email provided",
            location: "firebase_service_impl.dart");
      } else {
        errorMsg = Failure(e.code,
            message: "Unknown error", location: "firebase_service_impl.dart");
      }
      throw errorMsg;
    }
  }

  //Sign up
  @override
  Future<void> createAccountWithEmailAndPassword(
      name, email, password, role) async {
    try {
      //create user first
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      //add user detail to firestore
      await _firebaseFirestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({
        'userId': userCredential.user!.uid,
        'name': name,
        'email': email,
        'role': role,
        'restId': '',
        'userPic': '',
      });

      user = await getUser(currentUser.uid);
      // user successfully registered
    } on FirebaseAuthException catch (e) {
      Failure errorMsg;

      if (e.code == "email-already-in-use") {
        errorMsg = Failure(e.code,
            message: "The email address is already in use by another account.",
            location: "firebase_service_impl.dart");
      } else {
        errorMsg = Failure(e.code,
            message: "Unknown error", location: "firebase_service_impl.dart");
      }
      throw errorMsg;
    }
  }

  //Sign in
  @override
  Future<UserModel?> signInWithEmailAndPassword(email, password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      user = await getUser(currentUser.uid);
    } on FirebaseAuthException catch (e) {
      print(e);
      Failure errorMsg;
      //return error back to display screen
      if (e.code == "user-not-found") {
        errorMsg = Failure(e.code,
            message: "There is no user exist in database",
            location: "firebase_service_impl.dart");
      } else if (e.code == "wrong-password") {
        errorMsg = Failure(e.code,
            message: "Password not match",
            location: "firebase_service_impl.dart");
      } else {
        errorMsg = Failure(e.code,
            message: "Unknown error", location: "firebase_service_impl.dart");
      }
      throw errorMsg;
    }
    return user;
  }

// Sign Out
  @override
  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return 'Signed Out Successfully';
    } on FirebaseAuthException catch (e) {
      // print(e);
      //return error back to display screen
      return e.message.toString();
    }
  }

  @override
  Stream<User?> authStateChanges() {
    try {
      return _firebaseAuth.authStateChanges();
    } on FirebaseAuthException catch (e) {
      Failure errorMsg = const Failure("internal-error",
          message: "Failed to read user from the server",
          location: "firebase_service.dart");
      throw errorMsg;
    }
  }

  @override
  Stream? streamUser() {
    try {
      return _firebaseFirestore
          .collection('Users')
          .doc(currentUser.uid)
          .snapshots();
    } on FirebaseException catch (e) {
      print(e);
      throw Failure(e.code,
          message: e.message, location: "firebase_service_impl.dart");
    }
  }

  @override
  Future<void> editProfile(name, userPic) async {
    try {
      await _firebaseFirestore.collection('Users').doc(currentUser.uid).update({
        'name': name,
        'userPic': userPic,
      });
    } on FirebaseException catch (e) {
      print(e);
      throw Failure(e.code,
          message: e.message, location: "firebase_service_impl.dart");
    }
  }

  @override
  Future<UserModel> getUser(String id) async {
    try {
      var doc = await _firebaseFirestore.collection("Users").doc(id).get();
      if (!doc.exists) {
        //handle error
        //throw something maybe
      }
      return UserModel.fromJson(doc.data()!);
    } on FirebaseException catch (e) {
      throw Failure(e.code,
          message: "Failed to read user from the server",
          location: "firebase_service.dart");
    }
  }

  @override
  User? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    return user;
  }

  @override
  Future<void> initializeUser() async {
    user = await getUser(currentUser.uid);
  }

//restaurant services
  @override
  Future<Restaurant> getRestaurant(restId) async {
    try {
      var doc =
          await _firebaseFirestore.collection('Restaurants').doc(restId).get();
      return Restaurant.fromJson(doc.data()!);
    } on FirebaseException catch (e) {
      print(e);
      throw Failure(e.code,
          message: e.message, location: "firebase_service_impl.dart");
    }
  }

  @override
  Future<void> openClose(restStatus) async {
    try {
      if (restStatus == false) {
        await _firebaseFirestore
            .collection('Restaurants')
            .doc(user.restId)
            .update({
          'status': true,
        });
      } else {
        await _firebaseFirestore
            .collection('Restaurants')
            .doc(user.restId)
            .update({
          'status': false,
        });
      }
    } on FirebaseException catch (e) {
      print(e);
      throw Failure(e.code,
          message: e.message, location: "firebase_service_impl.dart");
    }
  }

  @override
  Future<List<Restaurant>> getAllRestaurant() async {
    try {
      List<Restaurant> restaurantList = [];
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection("Restaurants")
          .where("status", isEqualTo: true)
          .get();
      querySnapshot.docs.forEach((element) {
        restaurantList
            .add(Restaurant.fromJson(element.data() as Map<String, dynamic>));
      });
      return restaurantList;
    } on FirebaseException catch (e) {
      throw Failure(e.code,
          message: e.message, location: "firebase_service.dart");
    }
  }

  @override
  Future<String> signUpRestaurant(Restaurant restaurant) async {
    try {
      //create restaurant doc first
      var restId = await _firebaseFirestore
          .collection('Restaurants')
          .add(restaurant.toJson());
      _firebaseFirestore.collection('Restaurants').doc(restId.id).update({
        'restId': restId.id,
        'userId': currentUser.uid,
        'restPicture': "restaurant/" + restId.id + "/" + restaurant.restPicture,
      });
      //add restaurant id to user
      _firebaseFirestore.collection('Users').doc(currentUser.uid).update({
        'restId': restId.id,
      });
      return restId.id;
      //restaurant successfully registered
    } on FirebaseException catch (e) {
      print(e);
      throw Failure(e.code,
          message: e.message, location: "firebase_service_impl.dart");
    }
  }

  //menu services
  @override
  Future<void> addNewMenu(Menu menu, String restaurantId) async {
    try {
      DocumentReference menuDcoument =
          await _firebaseFirestore.collection("menu").add(menu.toJson());

      menuDcoument.id;
      //since the id is auto generated by firebase,
      //we need to update the field of the newly
      //created document with the generated Id
      _firebaseFirestore.collection("menu").doc(menuDcoument.id).update({
        "menuId": menuDcoument.id,
        "restId": restaurantId,
        "foodPicture": "menu/" + restaurantId + "/" + menu.foodPicture
      });
    } on FirebaseException catch (e) {
      throw Failure(e.code,
          message: "Failed to add menu to the server",
          location: "firebase_service_impl.dart");
    }
  }

  @override
  Future<void> editMenu(Menu menu, String restaurantId) async {
    try {
      await _firebaseFirestore.collection("menu").doc(menu.menuId).update({
        "restId": menu.restId,
        "foodPicture": "menu/" + restaurantId + "/" + menu.foodPicture,
        "category": menu.category,
        "foodDesc": menu.foodDesc,
        "foodName": menu.foodName,
        "foodPrice": menu.foodPrice,
      });
    } on FirebaseException catch (e) {
      throw Failure(e.code,
          message: "Failed to add menu to the server",
          location: "firebase_service_impl.dart");
    }
  }

  @override
  Future<List<Menu>> getAllRestaurantMenu(String restaurantId) async {
    try {
      List<Menu> listMenu = [];
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection("menu")
          .where("restId", isEqualTo: restaurantId)
          .get();
      querySnapshot.docs.forEach((element) {
        listMenu.add(Menu.fromJson(element.data() as Map<String, dynamic>));
      });
      return listMenu;
    } on FirebaseException catch (e) {
      throw Failure(e.code,
          message: "Failed to read menu from the server",
          location: "firebase_service.dart");
    }
  }

  @override
  Future<List<Menu>> getAllMenu() async {
    try {
      List<Menu> listMenu = [];
      QuerySnapshot querySnapshot =
          await _firebaseFirestore.collection("menu").get();
      querySnapshot.docs.forEach((element) {
        listMenu.add(Menu.fromJson(element.data() as Map<String, dynamic>));
      });
      return listMenu;
    } on FirebaseException catch (e) {
      throw Failure(e.code,
          message: "Failed to read menu from the server",
          location: "firebase_service.dart");
    }
  }
  
  @override
  Future<Menu> getMenu(String menuId) async {
    DocumentSnapshot menu =
        await _firebaseFirestore.collection("menu").doc(menuId).get();
    return Menu.fromJson(menu.data() as Map<String, dynamic>);
  }

  @override
  Stream? menuListListener() {
    return _firebaseFirestore
        .collection("menu")
        .where("restId", isEqualTo: user.restId)
        .snapshots();
  }

  @override
  Stream? get stream => menuListListener();

  @override
  Future<void> deleteMenu(String menuId) async {
    try {
      await _firebaseFirestore.collection("menu").doc(menuId).delete();
    } on FirebaseException catch (e) {
      throw Failure(e.code,
          message: "Cannot perform delete operation",
          location: "firebase_service_impl.dart");
    }
  }

//order services
  @override
  Future<Order> getOrder(String orderId) async {
    QuerySnapshot order = await _firebaseFirestore
        .collection("testOrders")
        .where("orderId", isEqualTo: orderId)
        .get();
    //if (order.docs.isEmpty) return null;
    return Order.fromJson(order.docs[0].data() as Map<String, dynamic>);
  }

  @override
  Future<List<Order>> getAllOrder(String resId) async {
    try {
      List<Order> listOrder = [];
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection("testOrders")
          .where('restId', isEqualTo: resId)
          .where('orderStatus', isEqualTo: 'Cooking')
          .get();
      querySnapshot.docs.forEach((element) {
        listOrder.add(Order.fromJson(element.data() as Map<String, dynamic>));
      });
      return listOrder;
    } on FirebaseException catch (e) {
      throw Failure(e.code,
          message: e.message, location: "firebase_service.dart");
    }
  }

  @override
  Future<List<Order>> getAllOrderHistory(String restaurantId) async {
    try {
      List<Order> listOrder = [];
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection("testOrders")
          .where('restId', isEqualTo: restaurantId)
          .where('orderStatus', isEqualTo: "Completed")
          .get();
      querySnapshot.docs.forEach((element) {
        listOrder.add(Order.fromJson(element.data() as Map<String, dynamic>));
      });
      return listOrder;
    } on FirebaseException catch (e) {
      throw Failure(e.code,
          message: e.message, location: "firebase_service.dart");
    }
  }

  @override
  Future<List<Order>> getAllCustOrder(String id) async {
    try {
      List<Order> listOrder = [];
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection("testOrders")
          .where('userId', isEqualTo: id)
          .where('orderStatus', isEqualTo: 'Cooking')
          .get();
      querySnapshot.docs.forEach((element) {
        listOrder.add(Order.fromJson(element.data() as Map<String, dynamic>));
      });
      return listOrder;
    } on FirebaseException catch (e) {
      throw Failure(e.code,
          message: e.message, location: "firebase_service.dart");
    }
  }

  @override
  Future<List<Order>> getAllCustOrderHistory(String id) async {
    try {
      List<Order> listOrder = [];
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection("testOrders")
          .where('userId', isEqualTo: id)
          .where('orderStatus', isEqualTo: 'Completed')
          .get();
      querySnapshot.docs.forEach((element) {
        listOrder.add(Order.fromJson(element.data() as Map<String, dynamic>));
      });
      return listOrder;
    } on FirebaseException catch (e) {
      throw Failure(e.code,
          message: e.message, location: "firebase_service.dart");
    }
  }

  @override
  Future<String> addOrderItem(OrderItem orderItem) async {
    try {
      DocumentReference orderItemDcoument = await _firebaseFirestore
          .collection("orderitem")
          .add(orderItem.toJson());
      //since the id is auto generated by firebase,
      //we need to update the field of the newly
      //created document with the generated Id
      await _firebaseFirestore
          .collection("orderitem")
          .doc(orderItemDcoument.id)
          .update({
        "orderItemId": orderItemDcoument.id,
      });

      return orderItemDcoument.id;
    } on FirebaseException catch (e) {
      throw Failure(e.code,
          message: e.message, location: "firebase_service.dart");
    }
  }

  @override
  Future<void> updateOrder(Order order) async {
    try {
      await _firebaseFirestore
          .collection("testOrders")
          .doc(order.orderId)
          .update(order.toJson());
    } on FirebaseException catch (e) {
      throw Failure(e.code,
          message: e.message, location: "firebase_service.dart");
    }
  }

  @override
  Future<void> deleteOrderItem(String orderItemId) async {
    try {
      await _firebaseFirestore
          .collection("orderitem")
          .doc(orderItemId)
          .delete();
    } on FirebaseException catch (e) {
      throw Failure(e.code,
          message: e.message, location: "firebase_service.dart");
    }
  }

  @override
  Future<String> createOrder(Order order) async {
    try {
      DocumentReference orderDcoument =
          await _firebaseFirestore.collection("testOrders").add(order.toJson());
      //since the id is auto generated by firebase,
      //we need to update the field of the newly
      //created document with the generated Id
      await _firebaseFirestore
          .collection("testOrders")
          .doc(orderDcoument.id)
          .update({
        "orderId": orderDcoument.id,
      });

      return orderDcoument.id;
    } on FirebaseException catch (e) {
      throw Failure(e.code,
          message: e.message, location: "firebase_service.dart");
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> orderListListener(String userId) {
    return _firebaseFirestore
        .collection("testOrders")
        .where("userId", isEqualTo: userId)
        .where("orderStatus", isEqualTo: 'cart')
        .snapshots();
  }

  @override
  Future<OrderItem> getOrderItem(String orderItemId) async {
    DocumentSnapshot orderItem =
        await _firebaseFirestore.collection("orderitem").doc(orderItemId).get();
    return OrderItem.fromJson(orderItem.data() as Map<String, dynamic>);
  }


  @override
  Future<void> updateOrderItem(OrderItem orderItem) async {
    await _firebaseFirestore
        .collection("orderitem")
        .doc(orderItem.orderItemId)
        .update(orderItem.toJson());
  }

  @override
  Future<Order?> getPendingOrder(String userId) async {
    QuerySnapshot order = await _firebaseFirestore
        .collection("testOrders")
        .where("userId", isEqualTo: userId)
        .where("orderStatus", isEqualTo: 'cart')
        .get();
    if (order.docs.isEmpty) return null;
    return Order.fromJson(order.docs[0].data() as Map<String, dynamic>);
  }

}
