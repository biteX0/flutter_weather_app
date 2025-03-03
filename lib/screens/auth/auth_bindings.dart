import 'package:weather/screens/auth/auth_controller.dart';
import 'package:get/get.dart';
import 'package:weather/screens/home/home_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(HomeController());
  }
}
