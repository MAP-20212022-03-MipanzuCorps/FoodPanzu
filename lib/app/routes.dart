import 'package:flutter/widgets.dart';
import 'package:foodpanzu/screens/restaurant_sign_up/restaurant_signup.dart';
import 'package:foodpanzu/screens/role_choice/role_choice_screen.dart';
import 'package:foodpanzu/screens/forgot_password/forgot_password_screen.dart';
import 'package:foodpanzu/screens/home/home_screen.dart';
import 'package:foodpanzu/screens/login_success/login_success_screen.dart';
import 'package:foodpanzu/screens/logout_success/logout_success_screen.dart';
import 'package:foodpanzu/screens/profile/profile_screen.dart';
import 'package:foodpanzu/screens/sign_in/sign_in_screen.dart';
import 'package:foodpanzu/screens/splash/splash_screen.dart';

import '../screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  LogOutSuccessScreen.routeName: (context) => LogOutSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  RoleChoiceScreen.routeName: (context) => RoleChoiceScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  SSMRegScreen.routeName: (context) => SSMRegScreen(),
};
