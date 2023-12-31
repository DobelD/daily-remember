import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/constant.dart';

class HeaderLoginSection extends StatelessWidget {
  const HeaderLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        SizedBox(
          height: 170.r,
          width: 170.r,
          child: Lottie.asset(splashJson),
        ),
        SizedBox(height: 12.h),
        Text('Welcome Back', style: headerBold),
        SizedBox(height: 12.h),
        Text(
            'Experience Progress in English: Your Path to Fluency, Confidence, and Mastery!',
            textAlign: TextAlign.center,
            style: hintTitleNormal),
        SizedBox(height: 24.h),
      ],
    );
  }
}
