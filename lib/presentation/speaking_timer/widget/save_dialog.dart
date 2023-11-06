import 'package:dailyremember/components/app_button.dart';
import 'package:dailyremember/components/app_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/speaking_timer.controller.dart';

class SaveDialog extends StatelessWidget {
  const SaveDialog({super.key, this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpeakingTimerController>();
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            AppForm(
              controller: controller.titleController,
              hintText: "Judul",
            ),
            const SizedBox(
              height: 12,
            ),
            AppButton(
              text: "Save",
              onPressed: onPressed,
            )
          ],
        ));
  }
}
