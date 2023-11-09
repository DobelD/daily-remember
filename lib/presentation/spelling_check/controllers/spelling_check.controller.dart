import 'package:dailyremember/components/app_button.dart';
import 'package:dio/dio.dart';
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

  // Future<void> checkGrammerSpelling() async {
  //   print(Get.arguments);
  //   Dio dio = Dio();
  //   try {
  //     final response = await dio.post(
  //         'https://api.textgears.com/spelling?text=${Get.arguments}&language=en-GB&ai=1&key=VKRVkaQcuZLGpBA6');
  //     print(response.statusCode);
  //     print(response.data);
  //   } catch (e) {
  //     if (e is DioException) {
  //       print(e.response?.data);
  //     }
  //   }
  // }

  @override
  void onInit() {
    text = Get.arguments;
    splitSpelling();
    super.onInit();
  }
}
