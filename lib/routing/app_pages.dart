import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:weather/routing/app_routes.dart';
import 'package:weather/screens/auth/auth_bindings.dart';
import 'package:weather/screens/auth/auth_or_home_screen.dart';
import 'package:weather/screens/auth/login_screen.dart';
import 'package:weather/screens/auth/registration_screen.dart';
import 'package:weather/screens/auth/reset_password.dart';
import 'package:weather/screens/home/home_bindings.dart';
import 'package:weather/screens/home/home_screen.dart';

abstract class AppPages {
  static const initial = Routes.initial;

  static final pages = [
    GetPage(
        name: Routes.mainPage,
        page: () => HomeScreen(),
        binding: HomeBinding(),
        preventDuplicates: true,
        ),
        GetPage(
          name: Routes.initial,
          page: () => AuthOrLoadingHomeScreen(),
          binding: AuthBinding(),
        ), 
        GetPage(
          name: Routes.registration,
          page: () => RegistrationScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: Routes.weatherPage,
          page: () => HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: Routes.resetPassword,
          page: () => ResetPasswordScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: Routes.loginScreen,
          page: () => LoginScreen(),
          binding: AuthBinding(),
        ),
  ];
}