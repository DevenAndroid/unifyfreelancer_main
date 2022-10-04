import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';

showError(String content) {
  Get.closeAllSnackbars();
  Get.snackbar('Status', content,
      colorText: AppTheme.darkBlueText,
      backgroundGradient: LinearGradient(colors: [
        Color(0xffa39ef5),
        Color(0xfff2bde2),
      ]),
      snackPosition: SnackPosition.BOTTOM);
}
