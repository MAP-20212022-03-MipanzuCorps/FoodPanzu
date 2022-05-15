import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:foodpanzu/app/service_locator.dart';
// import 'firebase_options.dart';

import 'package:foodpanzu/app/routes.dart';
// import 'package:foodpanzu/screens/profile/profile_screen.dart';
import 'package:foodpanzu/screens/splash/splash_screen.dart';
import 'package:foodpanzu/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodpanzu',
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
