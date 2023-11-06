import 'package:d_chart/commons/data_model.dart';
import 'package:dailyremember/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProgressController extends GetxController {
  final box = GetStorage();

  var vocabularyRemember = 0.obs;
  var vocabularyNotRemember = 0.obs;
  var rememberedVocabulary = <NumericData>[].obs;
  var targetVocabulary = <OrdinalData>[].obs;
  var doneRememberVocabulary = 0.obs;

  setProgressVocabulary() async {
    rememberedVocabulary.clear();
    vocabularyRemember.value = 0;
    vocabularyNotRemember.value = 0;
    final homeController = Get.find<HomeController>();
    if (homeController.wordsEnglish.isNotEmpty) {
      for (var item in homeController.wordsEnglish) {
        if (item.remember == true) {
          vocabularyRemember.value++;
        } else {
          vocabularyNotRemember++;
        }
      }
    }
    rememberedVocabulary.value = List.generate(
        2,
        (index) => NumericData(
            domain: index + 1,
            measure: index == 0
                ? vocabularyRemember.value
                : vocabularyNotRemember.value,
            color: index == 0 ? Colors.blueAccent : Colors.grey.shade200));
  }

  setTargetVocabulary() {
    String? target = box.read('target-vocab');
    int? remember = box.read('remember-vocab');
    targetVocabulary.value = List.generate(
        2,
        (index) => OrdinalData(
            domain: index == 0 ? 'Done' : 'Target',
            measure: index == 0
                ? remember ?? 0
                : int.parse(target == "0" ? '1' : target ?? ''),
            color: index == 0 ? Colors.red : Colors.grey.shade200));
  }

  @override
  void onInit() {
    setProgressVocabulary();
    super.onInit();
  }
}
