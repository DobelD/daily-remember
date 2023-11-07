import 'package:dailyremember/infrastructure/navigation/routes.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FooterLoginSection extends StatelessWidget {
  const FooterLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.h,
      width: Get.width,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200))),
      child: Center(
          child: RichText(
              text: TextSpan(
                  text: "Don't have an account? ",
                  style: hintSubTitleNormal,
                  children: [
            TextSpan(
                text: "Sign Up",
                style: subTitleBold,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.toNamed(Routes.REGISTER))
          ]))),
    );
  }
}
