import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class CardTarget extends StatelessWidget {
  const CardTarget(
      {super.key,
      required this.title,
      this.target,
      this.achieved,
      required this.icon,
      this.onPressed});
  final String title;
  final int? target;
  final int? achieved;
  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      width: Get.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              disabledBackgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.grey.shade200),
          onPressed: onPressed,
          child: Row(
            children: [
              Icon(
                icon,
                size: 20.r,
                color: Colors.black,
              ),
              SizedBox(width: 6.w),
              Text(title, style: titleNormal),
              const Spacer(),
              Icon(
                IconlyLight.arrow_right_2,
                size: 20.r,
                color: Colors.black,
              )
            ],
          )),
    );
    // return ListTile(
    //     title: Text(title, style: titleNormal),
    //     trailing: IconButton(
    //       onPressed: onPressed,
    //       icon: Icon(
    //         type == TypeTarget.vocabulary
    //             ? Icons.track_changes_outlined
    //             : IconlyLight.voice_2,
    //         color: target == 0 ? Colors.red : Colors.green,
    //       ),
    //     ));
  }
}
