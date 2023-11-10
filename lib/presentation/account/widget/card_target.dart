import 'package:dailyremember/components/progressbar.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/style_helper/default_border_radius.dart';

class CardTarget extends StatelessWidget {
  const CardTarget(
      {super.key,
      required this.title,
      this.isActiveTarget = false,
      this.target,
      this.achieved,
      this.onPressed});
  final String title;
  final bool isActiveTarget;
  final int? target;
  final int? achieved;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: const Color(0xFF6680C5).withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: radiusNormal,
      ),
      child: ListTile(
          title: Text(title, style: titleNormal), trailing: typeTrailling),
    );
  }

  Widget get typeTrailling {
    switch (isActiveTarget) {
      case true:
        return IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.track_changes_outlined,
            color: Colors.blueAccent,
          ),
        );
      default:
        return SizedBox(
          width: 100,
          child: Row(
            children: [
              Text(
                '$achieved/$target',
                style: subTitleNormal,
              ),
              SizedBox(width: 8.w),
              Expanded(
                  child: LinearProgressBar(
                      maxValue: target?.toDouble() ?? 0,
                      value: achieved?.toDouble() ?? 0)),
            ],
          ),
        );
    }
  }
}
