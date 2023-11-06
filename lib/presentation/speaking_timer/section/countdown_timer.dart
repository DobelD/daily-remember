import 'package:avatar_glow/avatar_glow.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/presentation/speaking_timer/controllers/speaking_timer.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CountDownTimer extends StatelessWidget {
  const CountDownTimer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpeakingTimerController());
    return Center(
      child: Container(
        child: Obx(() {
          String timeText =
              '${controller.selectedMinutes.value.toString().padLeft(2, '0')}:${controller.selectedSeconds.value.toString().padLeft(2, '0')}';
          return AvatarGlow(
              glowRadiusFactor: 0.4,
              animate: controller.isRunning.value ? true : false,
              duration: 2000.milliseconds,
              glowColor: Colors.blueAccent,
              child: GestureDetector(
                onTap: () {
                  controller.startRecordSpeakingTimer();
                },
                child: Container(
                  height: 120.r,
                  width: 120.r,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [Colors.white, Colors.blueAccent.shade100],
                        center: Alignment.center,
                        radius: 1.2,
                      ),
                      border: Border.all(
                          color: Colors.blueAccent.shade200, width: 2)),
                  child: Center(
                      child: Text(
                    controller.isRunning.value
                        ? timeText
                        : controller.isFinish.value
                            ? "Finish"
                            : controller.isReset.value
                                ? "Reset"
                                : "Start",
                    style: titleBold,
                  )),
                ),
              ));
        }),
      ),
    );
  }
}
