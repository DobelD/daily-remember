import 'package:dailyremember/presentation/account/widget/card_target.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
              target: controller.progressUser.targetRememberPerday ?? 0,
              achieved: controller.progressUser.achieved ?? 0,
            )
          ],
        );
      }),
    );
  }
}
