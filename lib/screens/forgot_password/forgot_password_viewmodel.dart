import 'package:foodpanzu/app/service_locator.dart';
import 'package:foodpanzu/services/service.dart';
import 'package:map_mvvm/viewmodel.dart';

class forgotPasswordModel extends Viewmodel {
  //service
  firebaseService get _firebaseService => locator<firebaseService>();

  Future<String> forgotPasswordUsingEmail(email) {
    return _firebaseService.forgotPasswordUsingEmail(email);
  }
}
