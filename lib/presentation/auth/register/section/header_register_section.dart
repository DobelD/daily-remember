import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../infrastructure/theme/typography.dart';
import '../../../../utils/constant.dart';

class HeaderRegisterSection extends StatelessWidget {
  const HeaderRegisterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        SizedBox(
          height: 100.r,
          width: 100.r,
          child: Lottie.asset(splashJson),
        ),
        SizedBox(height: 12.h),
        Text('Sign Up', style: headerBold),
        SizedBox(height: 12.h),
        Text('Create your account and see your progress learn!',
            textAlign: TextAlign.center, style: hintTitleNormal),
        SizedBox(height: 24.h),
      ],
    );
  }
}
