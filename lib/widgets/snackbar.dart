import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackType { success, error, warning }

class MySnackbar {
  static void showSnackbar({
    required String title,
    required String message,
    SnackType type = SnackType.success,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: _snackColor(type),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  static Color _snackColor(SnackType type) {
    switch (type) {
      case SnackType.success:
        return Colors.green;
      case SnackType.error:
        return Colors.red;
      case SnackType.warning:
        return Colors.orange;
    }
  }
}