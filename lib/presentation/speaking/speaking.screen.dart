import 'package:dailyremember/infrastructure/navigation/routes.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/presentation/speaking/section/list_recording.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import 'controllers/speaking.controller.dart';

class SpeakingScreen extends GetView<SpeakingController> {
  const SpeakingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Speaking',
              style: whiteHeaderBold,
            ),
            backgroundColor: Colors.blueAccent,
            elevation: 1),
        floatingActionButton: Obx(() {
          return SpeedDial(
            icon: controller.isOpenFloating.value
                ? Icons.close
                : IconlyBold.voice_2,
            heroTag: "speaking",
            backgroundColor: Colors.blueAccent,
            overlayOpacity: 0.6,
            overlayColor: Colors.black,
            onOpen: () {
              controller.isOpenFloating.value = true;
            },
            onClose: () {
              controller.isOpenFloating.value = false;
            },
            children: [
              SpeedDialChild(
                  child: const Icon(
                    IconlyLight.time_circle,
                    color: Colors.blueAccent,
                  ),
                  backgroundColor: Colors.white,
                  label: "Speaking Timer",
                  labelStyle: subTitleNormal,
                  onTap: () => Get.toNamed(Routes.SPEAKING_TIMER,
                      arguments: controller.speakingData.length)),
              SpeedDialChild(
                  child:
                      const Icon(IconlyLight.voice_2, color: Colors.blueAccent),
                  backgroundColor: Colors.white,
                  label: "Speaking",
                  labelStyle: subTitleNormal,
                  onTap: () {
                    controller.openMenuRecord(0);
                  })
            ],
          );
        }),
        body: const ListRecording());
  }
}
