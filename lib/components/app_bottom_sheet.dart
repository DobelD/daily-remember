import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import 'app_button.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet(
      {super.key,
      required this.title,
      required this.textButton,
      required this.child,
      this.isFooter = true,
      this.onPressed});
  const AppBottomSheet.witoutFooter(
      {super.key,
      required this.title,
      this.textButton = "",
      required this.child,
      this.isFooter = false,
      this.onPressed});

  final String title;
  final String textButton;
  final Widget child;
  final bool isFooter;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r))),
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Get.height * 0.9,
            minHeight: Get.height * 0.1,
          ),
          child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  SizedBox(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 60.w),
                        Padding(
                          padding: EdgeInsets.all(16.r),
                          child: SizedBox(child: child),
                        ),
                        SizedBox(height: isFooter ? 100.w : 32.w),
                      ],
                    ),
                  )),
                  Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Column(children: [
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.r, vertical: 12.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(title, style: titleBold),
                                GestureDetector(
                                    onTap: () => Get.back(),
                                    child: const Icon(IconlyLight.close_square))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                          height: 0,
                          thickness: 1,
                        ),
                        SizedBox(height: 16.w),
                      ])),
                  isFooter
                      ? Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: SizedBox(
                              width: Get.width,
                              child: Container(
                                height: 72.h,
                                padding: EdgeInsets.all(16.r),
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.grey.shade300))),
                                child: AppButton(
                                    text: textButton, onPressed: onPressed),
                              )))
                      : const SizedBox(),
                ],
              ))),
    );
  }
}
