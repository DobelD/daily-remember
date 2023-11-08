import 'package:dailyremember/components/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpellingCheckController extends GetxController {
  late TextEditingController transcribe;
  String text = "";
  var wordSplit = [].obs;

  splitSpelling() {
    text = text.replaceAll(RegExp(r'[.,]'), '');
    wordSplit.value = text.split(' ');
  }

  void changeValueWord(String value, index) {
    transcribe = TextEditingController(text: value);
    Get.defaultDialog(
        title: "",
        content: Column(
          children: [
            TextFormField(
              controller: transcribe,
            ),
            const SizedBox(height: 12),
            AppButton(
              text: "Change Value",
              onPressed: () {
                wordSplit[index] = transcribe.text;
                Get.back();
              },
            )
          ],
        ));
  }

  @override
  void onInit() {
    text = Get.arguments;
    splitSpelling();
    super.onInit();
  }
}
