import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarHelper {
  static void showErrorSnackBar(String message, {String title = "Error"}) {
    final screenWidth = MediaQuery.of(Get.context!).size.width;
    final margin = screenWidth >= 300
        ? EdgeInsets.symmetric(horizontal: 300)
        : EdgeInsets.zero;

    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      borderRadius: 20,
      margin: margin,
      duration: Duration(seconds: 3),
      icon: Icon(Icons.error, color: Colors.white),
    );
  }

  static void showSuccessSnackBar(String message, {String title = "Success"}) {
    final screenWidth = MediaQuery.of(Get.context!).size.width;
    final margin = screenWidth >= 300
        ? EdgeInsets.symmetric(horizontal: 300)
        : EdgeInsets.zero;

    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 20,
      margin: margin,
      duration: Duration(seconds: 3),
      icon: Icon(Icons.check_circle, color: Colors.white),
    );
  }
}
