import 'package:foodpanzu/screens/add_new_menu/add_new_menu_viewmodel.dart';
import 'package:foodpanzu/screens/edit_menu/edit_menu_viewmodel.dart';
import 'package:foodpanzu/screens/forgot_password/forgot_password_viewmodel.dart';
import 'package:foodpanzu/screens/owner_home/ownerhome_viewmodel.dart';
import 'package:foodpanzu/screens/owner_order/owner_order_viewmodel.dart';
import 'package:foodpanzu/screens/profile/profile_viewmodel.dart';
import 'package:foodpanzu/screens/sign_in/sign_in_viewmodel.dart';
import 'package:foodpanzu/screens/sign_up/sign_up_viewmodel.dart';
import 'package:foodpanzu/screens/restaurant_sign_up/restaurant_viewmodel.dart';
import 'package:foodpanzu/screens/home/home_viewmodel.dart';
import 'package:foodpanzu/screens/splash/splash_viewmodel.dart';
import 'package:map_mvvm/service_locator.dart';
import 'package:foodpanzu/services/service.dart';

import '../screens/owner_home/menu_cart_viewmodel.dart';

final locator = ServiceLocator.locator;

Future<void> initializeServiceLocator() async {
  // In case of using Firebase services, Firebase must be initialized first before the service locator,
  //  because viewmodels may need to access firebase during the creation of the objects.

  // To comply with Dependency Inversion, the Firebase.initializeApp() is called in a dedicated service file.
  //  So that, if you want to change to different services (other than Firebase), you can do so by simply
  //  defining another ServiceInitializer class.

  // await Firebase.initializeApp();

  // Register first and then run immediately
  locator.registerLazySingleton<ServiceInitializer>(
      () => ServiceInitializerFirebase());

  //inialize firebase
  final serviceInitializer = locator<ServiceInitializer>();
  await serviceInitializer.init();

  // Services
  locator.registerLazySingleton<firebaseService>(() => fireBaseServiceImpl());
  locator.registerLazySingleton<FireStorage>(() => FireStorageImpl());

  // Viewmodels
  locator
      .registerLazySingleton<forgotPasswordModel>(() => forgotPasswordModel());
  locator.registerLazySingleton<SignUpViewModel>(() => SignUpViewModel());
  locator.registerLazySingleton<SignInViewModel>(() => SignInViewModel());
  locator.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
  locator.registerLazySingleton<OwnerHomeViewModel>(() => OwnerHomeViewModel());
  locator.registerLazySingleton<OwnerOrderViewModel>(() => OwnerOrderViewModel());
  locator.registerLazySingleton<SplashViewModel>(() => SplashViewModel());
  locator
      .registerLazySingleton<RestaurantViewModel>(() => RestaurantViewModel());
  locator
      .registerLazySingleton<AddNewMenuViewModel>(() => AddNewMenuViewModel());
  locator
      .registerLazySingleton<EditMenuViewModel>(() => EditMenuViewModel());
  locator.registerLazySingleton<MenuListViewModel>(() => MenuListViewModel());
  locator.registerLazySingleton<ProfileViewModel>(() => ProfileViewModel());
}
