import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton.google(
      {super.key, this.onTap, this.image = googleImage, this.title = "Google"});
  const CustomButton.facebook(
      {super.key,
      this.onTap,
      this.image = facebookImage,
      this.title = "Facebook"});

  final Function()? onTap;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(6.r),
        child: Container(
          height: 46.0,
          padding: const EdgeInsets.all(8),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 20.r,
                width: 20.r,
              ),
              SizedBox(width: 6.w),
              Text(title, style: titleNormal)
            ],
          ),
        ),
      ),
    );
  }
}
