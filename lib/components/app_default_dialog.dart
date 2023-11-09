import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../infrastructure/theme/typography.dart';

class AppDefaultDialog {
  static show(
      {required String title, required String message, Function()? onTabYes}) {
    Get.defaultDialog(
        title: title,
        titleStyle: titleBold,
        middleText: message,
        middleTextStyle: subTitleNormal,
        titlePadding: const EdgeInsets.only(top: 12),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        radius: 8.r,
        actions: [
          TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'No',
                style: hintSubTitleBold,
              )),
          TextButton(
              onPressed: onTabYes,
              child: Text(
                'Yes',
                style: subTitleBold,
              ))
        ]);
  }
}
