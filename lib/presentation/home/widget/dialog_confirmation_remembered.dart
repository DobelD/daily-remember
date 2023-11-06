import 'package:dailyremember/components/app_button.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../domain/core/model/word_param.dart';

class DialogConfirmationRemembered extends StatelessWidget {
  const DialogConfirmationRemembered(
      {super.key, required this.data, required this.id, this.onPressed});

  final WordParam data;
  final int id;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 800.w, minHeight: 100.w),
              child: SingleChildScrollView(
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(20.w),
                          height: 250.w,
                          width: Get.width,
                          child: Lottie.asset(splashJson)),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            SizedBox(
                              width: Get.width * 0.9,
                              child: Text('Yakin udah hafal?',
                                  maxLines: 6,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: titleNormal),
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                      height: 34.h,
                                      width: 100.w,
                                      child: AppButton(
                                          text: 'Kembali',
                                          onPressed: () => Get.back())),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: SizedBox(
                                      height: 34.h,
                                      width: 100.w,
                                      child: AppButton(
                                          text: 'Yakin', onPressed: onPressed)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
