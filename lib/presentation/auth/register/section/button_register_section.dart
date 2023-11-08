import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/app_button.dart';
import '../controllers/register.controller.dart';

class ButtonRegisterSection extends StatelessWidget {
  const ButtonRegisterSection({super.key, required this.controller});

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppButton(
        isLoading: controller.registerStatus.value == RegisterStatus.loading,
        text: 'Sign Up',
        onPressed: () => controller.registerWithApi(),
      );
    });
  }
}
