import 'package:firebase_core/firebase_core.dart';

import 'service_initializer.dart';

class ServiceInitializerFirebase extends ServiceInitializer {
  @override
  Future<void> init() async {
    await Firebase.initializeApp();
  }
}
