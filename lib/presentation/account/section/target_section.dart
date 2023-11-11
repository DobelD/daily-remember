import 'package:dailyremember/presentation/account/widget/card_target.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../controllers/account.controller.dart';

class TargetSection extends StatelessWidget {
  const TargetSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: GetBuilder<AccountController>(builder: (controller) {
        return Column(
          children: [
            CardTarget(
              title: "Target Vocabulary",
              icon: Icons.track_changes_outlined,
              target: controller.progressUser.targetRememberPerday ?? 0,
              achieved: controller.progressUser.achieved ?? 0,
              onPressed: () => controller.progress(),
            ),
            SizedBox(height: 6.h),
            CardTarget(
              title: "Target Speaking",
              icon: IconlyBold.voice,
              target: controller.progressUser.targetRememberPerday ?? 0,
              achieved: controller.progressUser.achieved ?? 0,
              onPressed: () => controller.progress(),
            ),
            SizedBox(height: 6.h),
            const CardTarget(
              title: "Edit Profile",
              icon: IconlyBold.profile,
              onPressed: null,
            ),
            SizedBox(height: 16.h),
            Divider(
              height: 0,
              color: Colors.grey.shade300,
            ),
            SizedBox(height: 16.h),
            const CardTarget(
              title: "Help & Support",
              icon: IconlyBold.calling,
              onPressed: null,
            ),
            SizedBox(height: 6.h),
            CardTarget(
              title: "Logout",
              icon: IconlyBold.profile,
              onPressed: () => controller.logout(),
            ),
          ],
        );
      }),
    );
  }
}
