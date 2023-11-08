import 'package:dailyremember/presentation/auth/register/section/button_register_section.dart';
import 'package:dailyremember/presentation/auth/register/section/footer_register_section.dart';
import 'package:dailyremember/presentation/auth/register/section/form_register_section.dart';
import 'package:dailyremember/presentation/auth/register/section/header_register_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/register.controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            const HeaderRegisterSection(),
            FormRegisterSection(controller: controller),
            ButtonRegisterSection(controller: controller)
          ],
        ),
      ),
      bottomNavigationBar: const FooterRegisterSection(),
    );
  }
}
