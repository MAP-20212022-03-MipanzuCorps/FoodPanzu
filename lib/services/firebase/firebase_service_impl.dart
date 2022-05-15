import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodpanzu/models/user_model.dart';
import 'package:foodpanzu/services/firebase/firebase_service.dart';

class fireBaseServiceImpl extends firebaseService {
  @override
  Future<void> addUserToFireStore(UserModel userModel) async {
    final CollectionReference _userCollectionRef =
        FirebaseFirestore.instance.collection('Users');
    return await _userCollectionRef
        .doc(userModel.userId)
        .set(userModel.toJson());
  }

  @override
  Future<String> forgotPasswordUsingEmail(email) async {
    final _firebaseAuth = FirebaseAuth.instance;
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      //return result sucess to forgot password screen
      return "Password Reset Email Sent";
    } on FirebaseAuthException catch (e) {
      print(e);
      //return error back to display screen
      return e.message.toString();
    }
  }
}
