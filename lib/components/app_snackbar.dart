import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppSnackbar {
  static success({required String message}) {
    Get.showSnackbar(GetSnackBar(
      margin: EdgeInsets.all(12.r),
      borderRadius: 8.r,
      backgroundColor: Colors.green,
      message: message,
      duration: 2.seconds,
    ));
  }

  static error({required String message}) {
    Get.showSnackbar(GetSnackBar(
      margin: EdgeInsets.all(12.r),
      borderRadius: 8.r,
      backgroundColor: Colors.red,
      message: message,
      duration: 2.seconds,
    ));
  }
}
