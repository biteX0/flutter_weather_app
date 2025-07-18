import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:weather/snackbar_error_messages/sealed_class_snackbar.dart';

class SnackbarManager {
  static void showAppSnackBar(AppSnackBar snackBar) {
    Get.closeCurrentSnackbar();
    Get.showSnackbar(
      GetSnackBar(
        message: snackBar.message,
        duration: Duration(seconds: 5),
        margin: EdgeInsets.all(10),
        borderRadius: 12,
        snackPosition:SnackPosition.TOP,
      ),
    );
  }
}
