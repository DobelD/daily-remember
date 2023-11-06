import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinearProgressBar extends StatelessWidget {
  final double maxValue;
  final double value;

  const LinearProgressBar(
      {super.key, required this.maxValue, required this.value});

  @override
  Widget build(BuildContext context) {
    double progressPercentage = (value / maxValue).clamp(0.0, 1.0);

    return Container(
      height: 8.w,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey.shade200,
      ),
      child: Stack(
        children: [
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progressPercentage,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
