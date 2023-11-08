import 'package:dailyremember/presentation/progress/controllers/progress.controller.dart';
import 'package:dailyremember/presentation/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class MainPageController extends GetxController {
  var tabIndex = 0;

  changeTabIndex(int index) {
    String textMessage = index == 1
        ? "Speaking"
        : index == 2
            ? "Dictionary"
            : "Account";
    if (index != 2) {
      tabIndex = index;
      update();
      if (index == 3) {
        changeDataProgress();
      }
    } else {
      Get.showSnackbar(GetSnackBar(
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
        backgroundColor: Colors.red,
        message: "Fitur $textMessage belum tersedia",
        snackPosition: SnackPosition.TOP,
        duration: 2.seconds,
      ));
    }
  }

  List<Widget> listPages = [
    const HomeScreen(),
    const SpeakingScreen(),
    const DictionaryScreen(),
    const AccountScreen()
  ];

  List<Map<String, dynamic>> listIcon = [
    {"label": "Home", "icon": IconlyBold.home},
    {"label": "Speaking", "icon": IconlyBold.voice_2},
    {"label": "Dictionary", "icon": IconlyBold.document},
    {"label": "Profile", "icon": IconlyBold.profile}
  ];

  changeDataProgress() {
    final progressController = Get.find<ProgressController>();
    progressController.setProgressVocabulary();
    progressController.setTargetVocabulary();
  }
}
