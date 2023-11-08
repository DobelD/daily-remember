import 'package:dailyremember/components/app_form.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:languagetool_textfield/languagetool_textfield.dart';

import 'controllers/spelling_check.controller.dart';

class SpellingCheckScreen extends GetView<SpellingCheckController> {
  const SpellingCheckScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpellingCheckScreen'),
        centerTitle: true,
      ),
      // body: TextFormField(
      //   controller: controller.transcribe,
      //   maxLines: 100,
      //   decoration: InputDecoration(
      //       border: _border,
      //       enabledBorder: _border,
      //       focusedBorder: _borderActive),
      // )
      body: Obx(() {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Wrap(
                spacing: 4.r, // Jarak antara kata-kata
                children: List.generate(controller.wordSplit.length, (index) {
                  return ChoiceChip(
                    selected: false,
                    backgroundColor: Colors.blueAccent,
                    selectedColor: Colors.red,
                    label: Text(controller.wordSplit[index],
                        style: whiteTitleNormal),
                    onSelected: (value) {
                      controller.changeValueWord(
                          controller.wordSplit[index], index);
                    },
                  );
                })),
          ],
        );
      }),
    );
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300));
  }

  OutlineInputBorder get _borderActive {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 1.2));
  }
}
