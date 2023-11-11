import 'package:dailyremember/components/app_bottom_sheet.dart';
import 'package:dailyremember/infrastructure/dal/repository/transcribe_repository_impl.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/presentation/speaking/controllers/speaking.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/dal/repository/speaking_repository_impl.dart';

class TranscribeAudioWidget extends StatelessWidget {
  const TranscribeAudioWidget({super.key, required this.transcribe});
  final String transcribe;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpeakingController>(
        init: SpeakingController(
            TranscribeRepositoryImpl(), SpeakingRepositoryImpl()),
        builder: (controller) {
          return AppBottomSheet(
              title: "Transcribe Audio",
              textButton: "Check Spelling",
              onPressed: null,
              child: Text(
                transcribe,
                style: titleNormal,
                textAlign: TextAlign.justify,
              ));
        });
  }
}
