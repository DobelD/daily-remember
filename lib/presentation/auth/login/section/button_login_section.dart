import 'package:dailyremember/components/app_button.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/presentation/auth/login/controllers/login.controller.dart';
import 'package:dailyremember/presentation/auth/login/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ButtonLoginSection extends StatelessWidget {
  const ButtonLoginSection({super.key, required this.controller});
  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
                onPressed: () => controller.forgotPassword(),
                child:
                    Text('Forgot password ?', style: primarySubTitleNormal))),
        SizedBox(height: 4.h),
        Row(
          children: [
            Expanded(
              flex: 9,
              child: Obx(() {
                return AppButton(
                  isLoading:
                      controller.loginStatus.value == LoginStatus.loading,
                  text: 'Sign In',
                  onPressed: () => controller.loginWithApi(),
                );
              }),
            ),
            SizedBox(width: 8.w),
            Expanded(
                flex: 2,
                child: AppButton.icon(
                  icon: Icons.fingerprint_outlined,
                  bgColor: Colors.grey.shade300,
                  onPressed: () => controller.loginWithFingerprint(),
                ))
          ],
        ),
        SizedBox(height: 32.h),
        Row(
          children: [
            Expanded(
                child: Divider(
              height: 0,
              color: Colors.grey.shade200,
              thickness: 1.1,
            )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  'Or Sign In With',
                  style: hintSubTitleNormal,
                )),
            Expanded(
                child: Divider(
              height: 0,
              color: Colors.grey.shade200,
              thickness: 1.1,
            ))
          ],
        ),
        SizedBox(height: 32.h),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: CustomButton.google(
                onTap: () => controller.loginWithGoogle(),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              flex: 5,
              child: CustomButton.facebook(
                onTap: () => controller.loginWithFacebook(),
              ),
            ),
          ],
        )
      ],
    );
  }
}
