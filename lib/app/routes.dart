import 'package:flutter/widgets.dart';
import 'package:foodpanzu/models/menu_model.dart';
<<<<<<< HEAD
import 'package:foodpanzu/screens/add_order/add_order_screen.dart';
=======
import 'package:foodpanzu/screens/cust_order/cust_order_screen.dart';
>>>>>>> 60f4ddbbfbf349aa8d609d567eeb6d9526efa49b
import 'package:foodpanzu/screens/owner_dashboard/dashboard_screen.dart';
import 'package:foodpanzu/screens/owner_order/owner_order_screen.dart';
import 'package:foodpanzu/screens/restaurant_sign_up/restaurant_signup_screen.dart';
import 'package:foodpanzu/screens/add_new_menu/add_new_menu_screen.dart';
import 'package:foodpanzu/screens/edit_menu/edit_menu_screen.dart';
import 'package:foodpanzu/screens/forgot_password/forgot_password_screen.dart';
import 'package:foodpanzu/screens/home/home_screen.dart';
import 'package:foodpanzu/screens/owner_home/ownerhome_screen.dart';
import 'package:foodpanzu/screens/login_success/login_success_screen.dart';
import 'package:foodpanzu/screens/logout_success/logout_success_screen.dart';
import 'package:foodpanzu/screens/profile/profile_screen.dart';
import 'package:foodpanzu/screens/sign_in/sign_in_screen.dart';
import 'package:foodpanzu/screens/splash/splash_screen.dart';
import 'package:foodpanzu/screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  //sign in, sign up, forgot password, logout
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  LogOutSuccessScreen.routeName: (context) => LogOutSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  RestaurantSignUpScreen.routeName: (context) => RestaurantSignUpScreen(),

  //bottom navigation bar
  HomeScreen.routeName: (context) => HomeScreen(),
  OwnerHomeScreen.routeName: (context) => OwnerHomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  DashboardScreen.routeName: (context) => DashboardScreen(),
  OwnerOrderScreen.routeName: (context) => OwnerOrderScreen(),

  //menu
  EditMenuScreen.routeName: (context) => EditMenuScreen(menu: Menu()),
  AddNewMenuScreen.routeName: (context) => AddNewMenuScreen(),

  //order
  AddOrderScreen.routeName: (context) => AddOrderScreen(menu: Menu()),
  //Customer Order
  CustOrderScreen.routeName: (context) => CustOrderScreen(),
};
