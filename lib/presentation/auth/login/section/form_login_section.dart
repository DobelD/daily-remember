import 'package:dailyremember/components/app_form.dart';
import 'package:dailyremember/presentation/auth/login/controllers/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormLoginSection extends StatelessWidget {
  const FormLoginSection({super.key, required this.controller});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppForm(
          controller: controller.emailController,
          hintText: "Email...",
        ),
        SizedBox(height: 12.h),
        AppForm(
          controller: controller.passwordController,
          hintText: "Password...",
        ),
        SizedBox(height: 4.h),
      ],
    );
  }
}
