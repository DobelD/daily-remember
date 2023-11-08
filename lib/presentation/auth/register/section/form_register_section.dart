import 'package:dailyremember/presentation/auth/register/controllers/register.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../components/app_form.dart';

class FormRegisterSection extends StatelessWidget {
  const FormRegisterSection({super.key, required this.controller});

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppForm(
          controller: controller.nameController,
          hintText: "Full Name...",
        ),
        SizedBox(height: 12.h),
        AppForm(
          controller: controller.usernameController,
          hintText: "Username...",
        ),
        SizedBox(height: 12.h),
        AppForm(
          controller: controller.emailController,
          hintText: "Email...",
        ),
        SizedBox(height: 12.h),
        AppForm(
          controller: controller.phoneNumberController,
          hintText: "Phone Number...",
        ),
        SizedBox(height: 12.h),
        AppForm.password(
          controller: controller.passwordController,
          hintText: "Password...",
        ),
        SizedBox(height: 12.h),
        AppForm.password(
          controller: controller.confirmPasswordController,
          hintText: "Confirmation Password...",
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
