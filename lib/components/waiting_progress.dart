import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WaitingProgress {
  static init({required String title}) {
    Get.defaultDialog(
        title: '',
        titlePadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        radius: 8.r,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title...',
              style: subTitleNormal,
            ),
            SizedBox(
              height: 24.r,
              width: 24.r,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ));
  }
}
