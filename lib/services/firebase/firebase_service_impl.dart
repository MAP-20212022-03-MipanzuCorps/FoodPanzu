// ignore_for_file: camel_case_types, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';
import 'package:map_mvvm/failure.dart';

class fireBaseServiceImpl extends firebaseService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;
  User get currentUser => _firebaseAuth.currentUser!;

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
      var _user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      //add user detail to firestore
      await _firebaseFirestore.collection('Users').doc(_user.user!.uid).set({
        'userId': _user.user!.uid,
        'name': name,
        'email': email,
        'role': role,
        'restId': '',
      });
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
  Future<UserModel> signInWithEmailAndPassword(email, password) async {
    UserModel currUser;
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      var snapshot = await _firebaseFirestore
          .collection('Users')
          .doc(user.user!.uid)
          .get();

      currUser = UserModel.fromJson(snapshot.data()!);

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
    return currUser;
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
  User? authStateChanges() {
    User? user;
    try {
      _firebaseAuth.authStateChanges().listen((event) {
        user = event;
        // print(user);
      });
    } on FirebaseAuthException catch (e) {
      Failure errorMsg = const Failure("internal-error",
          message: "Failed to read user from the server",
          location: "firebase_service.dart");
      throw errorMsg;
    }
    return user;
  }

  @override
  User? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    return user;
  }

// Fetch User Information
  // @override
  // Future<String> fetchRole() async {
  //   String role = '';
  //   try {
  //     var snapshot = await _firebaseFirestore
  //         .collection('Users')
  //         .doc(currentUser.uid)
  //         .get();
  //     role = snapshot.data()?['role'] as String;
  //   } on FirebaseException catch (e) {
  //     print(e);
  //     // throw signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!';
  //   } catch (e) {
  //     print(e);
  //     // throw '${e.toString()} Error Occured!';
  //   }
  //   return role;
  // }

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
}
