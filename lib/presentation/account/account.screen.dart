import 'package:dailyremember/infrastructure/theme/typography.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Profile', style: whiteHeaderBold),
        elevation: 1,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(2.seconds, () {
              controller.getProgress();
              controller.getUserProfile();
            });
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ProfileSection(controller: controller),
              const TargetSection()
            ],
          ),
        ),
      ),
      // bottomNavigationBar: FooterAccountSection(controller: controller),
    );
  }
}
