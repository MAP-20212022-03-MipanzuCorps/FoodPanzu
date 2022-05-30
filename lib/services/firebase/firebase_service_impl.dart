// ignore_for_file: camel_case_types, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  User? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    return user;
  }

// Fetch User role
  @override
  Future<String> fetchRole() async {
    String role = '';
    try {
      var snapshot = await _firebaseFirestore
          .collection('Users')
          .doc(currentUser.uid)
          .get();
      role = snapshot.data()?['role'] as String;
    } on FirebaseException catch (e) {
      print(e);
      // throw signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!';
    } catch (e) {
      print(e);
      // throw '${e.toString()} Error Occured!';
    }
    return role;
  }

  @override
  Future<void> signUpRestaurant(Restaurant restaurant) async {
    try {
      //create restaurant doc first
      var restId = await _firebaseFirestore
          .collection('Restaurants')
          .add(restaurant.toJson());
      _firebaseFirestore.collection('Restaurants').doc(restId.id).update({
        'restId': restId.id,
      });
      //add restaurant id to user
      _firebaseFirestore.collection('Users').doc(currentUser.uid).update({
        'restId': restId.id,
      });
      //restaurant successfully registered
    } on FirebaseException catch (e) {
      print(e);
      Failure errorMsg;

      // if (e.code == "email-already-in-use") {
      //   errorMsg = Failure(e.code,
      //       message: "The email address is already in use by another account.",
      //       location: "firebase_service_impl.dart");
      // } else {
      //   errorMsg = Failure(e.code,
      //       message: "Unknown error", location: "firebase_service_impl.dart");
      // }
      // throw errorMsg;
    }
  }

  @override
  Future<void> addNewMenu(Menu menu, String restaurantId) async {
    try {
      DocumentReference menuDcoument = await _firebaseFirestore
          .collection("Restaurants")
          .doc(restaurantId)
          .collection("menu")
          .add(menu.toJson());

      menuDcoument.id;
      //since the id is auto generated by firebase,
      //we need to update the field of the newly
      //created document with the generated Id
      _firebaseFirestore
          .collection("Restaurants")
          .doc(restaurantId)
          .collection("menu")
          .doc(menuDcoument.id)
          .update({"menuId": menuDcoument.id});
    } on FirebaseException catch (e) {
      print(e.message);
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
      throw e;
    }
  }

  @override
  Future<List<Menu>> getAllMenu(String restaurantId) async {
    try {
      List<Menu> listMenu = [];
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection("Restaurants")
          .doc(restaurantId)
          .collection("menu")
          .get();
      querySnapshot.docs.forEach((element) {
        listMenu.add(Menu.fromJson(element.data() as Map<String, dynamic>));
      });
      return listMenu;
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  @override
  Future<void> initializeUser() async {
    user = await getUser(currentUser.uid);
  }

  @override
  Stream? menuListListener() {
    // if (user == null) {
    //   return null;
    // } else {
    return _firebaseFirestore
        .collection("Restaurants")
        .doc(user.restId)
        .collection("menu")
        .snapshots();
    // .map((snapShot) => snapShot.docs
    //     .map((document) => Menu.fromJson(document.data()))
    //     .toList());
    // }
  }

  @override
  Stream? get stream => menuListListener();

  @override
  Future<void> deleteMenu(String menuId) async {
    await _firebaseFirestore
        .collection("testRestaurant")
        .doc(user.restId)
        .collection("menu")
        .doc(menuId)
        .delete();
  }
}
