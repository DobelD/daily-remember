import 'package:dailyremember/components/progressbar.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/speaking.controller.dart';

class PlayerBar extends StatelessWidget {
  const PlayerBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpeakingController>();
    return Container(
      width: Get.width,
      height: Get.height * 0.11,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Obx(() {
            return LinearProgressBar(
                maxValue: controller.maxDuration.value,
                value: controller.playingDuration.value);
          }),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                String timeText =
                    '${controller.minutes.value.toString().padLeft(2, '0')}:${controller.seconds.value.toString().padLeft(2, '0')}';
                return Text(timeText, style: hintSubTitleNormal);
              }),
              GestureDetector(
                  onTap: () => controller.pauseResumeAudio(),
                  child: Obx(() {
                    return Icon(
                      controller.isStop.value
                          ? Icons.stop_circle_outlined
                          : Icons.pause_circle_outline_rounded,
                      color: controller.isStop.value
                          ? Colors.red
                          : Colors.grey.shade400,
                      size: 26,
                    );
                  })),
              GestureDetector(
                  onTap: () => controller.stopPlayingAudio(),
                  child: const Icon(
                    Icons.done_rounded,
                    color: Colors.green,
                    size: 26,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
