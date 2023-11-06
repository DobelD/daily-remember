import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/presentation/speaking/section/list_recording.dart';
import 'package:flutter/material.dart';

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
          elevation: 1,
          actions: [
            IconButton(
                onPressed: () => controller.openDialogTarget(),
                icon: const Icon(
                  Icons.track_changes_outlined,
                  color: Colors.white,
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "speaking",
          onPressed: () => controller.openMenuRecord(0),
          backgroundColor: Colors.blueAccent,
          child: const Icon(IconlyBold.voice_2),
        ),
        body: const ListRecording());
  }
}
