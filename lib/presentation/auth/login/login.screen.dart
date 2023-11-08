import 'package:dailyremember/presentation/auth/login/section/button_login_section.dart';
import 'package:dailyremember/presentation/auth/login/section/footer_login_section.dart';
import 'package:dailyremember/presentation/auth/login/section/form_login_section.dart';
import 'package:dailyremember/presentation/auth/login/section/header_login_section.dart';
import 'package:dailyremember/presentation/auth/login/widget/waiting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loginStatus.value == LoginStatus.waiting) {
        return const WaitingScreen();
      }
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.all(16.r),
              children: [
                const HeaderLoginSection(),
                FormLoginSection(
                  controller: controller,
                ),
                ButtonLoginSection(controller: controller)
              ],
            ),
          ),
          bottomSheet: const FooterLoginSection());
    });
  }
}
