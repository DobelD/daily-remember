import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/progressbar.dart';
import '../../../domain/core/model/progress_model.dart';

class ProgressTarget extends StatelessWidget {
  const ProgressTarget({super.key, required this.data});
  final ProgressModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Target Harian",
              style: subTitleBold,
            ),
            Text(
              data.achieved == data.targetRememberPerday
                  ? "Complited"
                  : "${data.achieved}/${data.targetRememberPerday}",
              style: data.achieved == data.targetRememberPerday
                  ? primarySubTitleBold
                  : subTitleBold,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        LinearProgressBar(
            maxValue: data.targetRememberPerday?.toDouble() ?? 0,
            value: data.achieved?.toDouble() ?? 0),
        SizedBox(height: 16.h),
        Text(
          "Target ${data.targetDay} Hari",
          style: subTitleBold,
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 4.w,
          runSpacing: 4.w,
          children: List.generate(
              data.targetDay ?? 0,
              (index) => Container(
                    height: 22.r,
                    width: 22.r,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: index >= data.runningDay!
                                ? Colors.grey.shade400
                                : Colors.blueAccent,
                            width: 1.4),
                        color: index >= data.runningDay!
                            ? Colors.grey.shade200
                            : Colors.blueAccent.withOpacity(0.2)),
                    child: Center(
                        child: Text("${index + 1}",
                            style: GoogleFonts.inter(
                                fontSize: 8.sp,
                                color: index >= data.runningDay!
                                    ? Colors.grey.shade500
                                    : Colors.blueAccent,
                                fontWeight: FontWeight.normal))),
                  )),
        )
      ],
    );
  }
}
