import 'package:dailyremember/domain/core/model/local_storage/vocabulary.dart';
import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:dailyremember/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconly/iconly.dart';

import '../../../domain/core/model/word_model.dart';

class DetailWord extends StatelessWidget {
  const DetailWord({super.key, required this.data});

  final WordModel data;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Container(
      height: Get.height * 0.36,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Column(
        children: List.generate(
            6,
            (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: Row(
                    children: [
                      const Icon(
                        IconlyBold.arrow_right_2,
                        color: Colors.blueAccent,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                          flex: 3,
                          child: Text(
                            title(index),
                            style: titleBold,
                          )),
                      Expanded(
                          flex: 7,
                          child: Text(
                            value(
                                index: index,
                                english: data.english,
                                v1: data.verbOne,
                                v2: data.verbTwo,
                                v3: data.verbThree,
                                vIng: data.verbIng,
                                indo: data.indonesia),
                            style: titleNormal,
                          )),
                      Expanded(
                          flex: 2,
                          child: index != 0 && index != 5
                              ? GestureDetector(onTap: () {
                                  String targetText = '';

                                  switch (index) {
                                    case 1:
                                      targetText = data.verbOne ?? '';
                                      break;
                                    case 2:
                                      targetText = data.verbTwo ?? '';
                                      break;
                                    case 3:
                                      targetText = data.verbThree ?? '';
                                      break;
                                    case 4:
                                      targetText = data.verbIng ?? '';
                                      break;
                                  }
                                  controller.playAudioRecord(targetText, index);

                                  // controller.printFilesInDirectory();
                                }, child: Obx(() {
                                  return Icon(
                                    IconlyBold.volume_up,
                                    size: 18,
                                    color: controller.isPlaying[index] == false
                                        ? Colors.black
                                        : Colors.blueAccent,
                                  );
                                }))
                              : const SizedBox())
                    ],
                  ),
                )),
      ),
    );
  }

  String title(int index) {
    return index == 0
        ? "English"
        : index == 5
            ? "Indonesia"
            : "Verb ${index == 4 ? 'Ing' : index}";
  }

  String value(
      {String? english,
      String? v1,
      String? v2,
      String? v3,
      String? vIng,
      String? indo,
      required int index}) {
    String nullValue = "-";
    if (index == 0) {
      return english ?? nullValue;
    } else if (index == 1) {
      return v1 ?? nullValue;
    } else if (index == 2) {
      return v2 ?? nullValue;
    } else if (index == 3) {
      return v3 ?? nullValue;
    } else if (index == 4) {
      return vIng ?? nullValue;
    } else {
      return indo ?? nullValue;
    }
  }

  TextStyle styleText(
      {String? english,
      String? v1,
      String? v2,
      String? v3,
      String? vIng,
      String? indo,
      required int index}) {
    TextStyle nullValue = hintTitleNormal;
    TextStyle notNullValue = titleNormal;

    if (index == 0) {
      return english != null ? notNullValue : nullValue;
    } else if (index != 1) {
      return v1 != null ? notNullValue : nullValue;
    } else if (index != 2) {
      return v2 != null ? notNullValue : nullValue;
    } else if (index != 3) {
      return v3 != null ? notNullValue : nullValue;
    } else if (index != 4) {
      return vIng != null ? notNullValue : nullValue;
    } else {
      return indo != null ? notNullValue : nullValue;
    }
  }
}
