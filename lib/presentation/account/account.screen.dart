import 'package:dailyremember/presentation/account/section/footer_account_section.dart';
import 'package:dailyremember/presentation/account/section/target_section.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/account.controller.dart';
import 'section/profile_section.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ProfileSection(controller: controller),
            const TargetSection()
          ],
        ),
      ),
      bottomNavigationBar: FooterAccountSection(controller: controller),
    );
  }
}
