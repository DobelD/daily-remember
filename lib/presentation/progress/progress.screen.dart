import 'package:dailyremember/presentation/progress/section/speaking_progress.dart';
import 'package:dailyremember/presentation/progress/section/vocabulary_progress.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../infrastructure/theme/typography.dart';
import 'controllers/progress.controller.dart';

class ProgressScreen extends GetView<ProgressController> {
  const ProgressScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Progress',
            style: whiteHeaderBold,
          ),
          backgroundColor: Colors.blueAccent,
          elevation: 1,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            VocabularyProgress(),
            SizedBox(height: 8),
            SpeakingProgress()
          ],
        ));
  }
}
