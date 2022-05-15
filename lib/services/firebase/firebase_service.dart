import '../../models/user_model.dart';

abstract class firebaseService {
  Future<void> addUserToFireStore(UserModel userModel);
  Future<String> forgotPasswordUsingEmail(email);
}
