import 'package:dailyremember/components/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/account.controller.dart';

class FooterAccountSection extends StatelessWidget {
  const FooterAccountSection({super.key, required this.controller});
  final AccountController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      height: 72.h,
      decoration: const BoxDecoration(),
      child: AppButton(text: "Log Out", onPressed: () => controller.logout()),
    );
  }
}
