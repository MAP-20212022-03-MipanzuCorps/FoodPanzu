import 'package:foodpanzu/screens/forgot_password/forgot_password_viewmodel.dart';
import 'package:foodpanzu/screens/role_choice/role_choice_viewmodel.dart';
import 'package:foodpanzu/screens/sign_in/sign_in_viewmodel.dart';
import 'package:foodpanzu/screens/sign_up/sign_up_viewmodel.dart';
import 'package:foodpanzu/screens/home/home_viewmodel.dart';
import 'package:foodpanzu/screens/splash/splash_viewmodel.dart';
import 'package:map_mvvm/service_locator.dart';

// import '../ui/screens/home/home_viewmodel.dart';
import 'package:foodpanzu/services/service.dart';

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

  // Viewmodels
  locator
      .registerLazySingleton<forgotPasswordModel>(() => forgotPasswordModel());
  locator.registerLazySingleton<SignUpViewModel>(() => SignUpViewModel());
  locator.registerLazySingleton<SignInViewModel>(() => SignInViewModel());
  locator
      .registerLazySingleton<RoleChoiceViewModel>(() => RoleChoiceViewModel());
  locator.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
  locator.registerLazySingleton<SplashViewModel>(() => SplashViewModel());
}
