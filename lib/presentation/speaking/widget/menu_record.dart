import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/presentation/speaking/controllers/speaking.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuRecord extends StatelessWidget {
  const MenuRecord({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpeakingController>();
    return Container(
      width: Get.width,
      height: Get.height * 0.12,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Obx(() {
                String timeText =
                    '${controller.minutes.value.toString().padLeft(2, '0')}:${controller.seconds.value.toString().padLeft(2, '0')}';
                return Text(
                  timeText,
                  style: titleRegular,
                );
              }),
              const SizedBox(width: 8),
              AudioWaveforms(
                size: Size(Get.width * 0.76, 30.0),
                recorderController: controller.recordController,
                enableGesture: false,
                waveStyle: WaveStyle(
                  waveColor: Colors.grey.shade400,
                  showDurationLabel: false,
                  spacing: 6.0,
                  waveThickness: 2,
                  showHourInDuration: true,
                  showBottom: true,
                  extendWaveform: true,
                  showMiddleLine: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () => controller.onDeleteRecord(),
                  child: const Icon(
                    Icons.delete_rounded,
                    color: Colors.red,
                    size: 26,
                  )),
              GestureDetector(
                  onTap: () => controller.onResumeStopRecord(),
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
                  onTap: () => controller.openSaveDialog(),
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
