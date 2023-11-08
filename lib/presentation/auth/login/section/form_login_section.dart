import 'package:dailyremember/components/app_form.dart';
import 'package:dailyremember/presentation/auth/login/controllers/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widget/autocomplite_form.dart';

class FormLoginSection extends StatelessWidget {
  const FormLoginSection({super.key, required this.controller});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Column(
        children: [
          // AppForm(
          //   controller: controller.emailController,
          //   hintText: "Email...",
          // ),
          const AutocompliteForm(),
          SizedBox(height: 12.h),
          AppForm.password(
            controller: controller.passwordController,
            hintText: "Password...",
          ),
          SizedBox(height: 4.h),
        ],
      );
    });
  }
}
