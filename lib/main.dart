import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/screens/auth/auth_bindings.dart';
import 'package:weather/screens/auth/auth_controller.dart';
import 'package:weather/screens/auth/registration_screen.dart';
import 'package:weather/screens/home/home_bindings.dart';
import 'package:weather/firebase_options.dart';
import 'package:weather/screens/auth/auth_or_home_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather/screens/home/home_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  Intl.defaultLocale = 'ru';
  initializeDateFormatting('ru', null);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends GetView<AuthController> {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      initialRoute: '/',
      initialBinding: HomeBinding(),
      getPages: [
        GetPage(
          name: '/',
          page: () => AuthOrLoadingHomeScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/registraion',
          page: () => RegistrationScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/weather',
          page: () => HomeScreen(),
          binding: HomeBinding(),
        ),
      ],
    );
  }
}
