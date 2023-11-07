import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderLoginSection extends StatelessWidget {
  const HeaderLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        CircleAvatar(
          radius: 54.r,
          backgroundColor: Colors.blueAccent.shade100,
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
