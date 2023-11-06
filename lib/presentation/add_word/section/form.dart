import 'package:dailyremember/components/app_button.dart';
import 'package:dailyremember/components/app_form.dart';
import 'package:dailyremember/presentation/add_word/controllers/add_word.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormSection extends StatelessWidget {
  const FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddWordController>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        AppForm(
          controller: controller.english,
          hintText: "English word",
        ),
        const SizedBox(height: 12),
        SizedBox(
            child: Column(
                children: List.generate(
          controller.listTextController.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: AppForm(
                    controller: controller.listTextController[index],
                    hintText: controller.listHintText[index],
                    onChanged: (value) =>
                        controller.checkValueForm(value, index),
                  ),
                ),
                SizedBox(
                    width: 50,
                    child: Obx(() {
                      return IconButton(
                          onPressed:
                              controller.isActiveRecording[index] == false
                                  ? () => controller.messageRequeredValue()
                                  : () => controller.openMenuRecord(index),
                          icon: Icon(Icons.mic_rounded,
                              color:
                                  controller.isActiveRecording[index] == false
                                      ? Colors.grey.shade300
                                      : Colors.black));
                    }))
              ],
            ),
          ),
        ))),
        AppForm(
          controller: controller.indonesia,
          hintText: "Meaning",
        ),
        const SizedBox(height: 32),
        Obx(() {
          return AppButton(
            text: Get.arguments['type'] != "update" ? "Add Word" : "Edit Word",
            onPressed: () => controller.createWord(),
            // ignore: unrelated_type_equality_checks
            isLoading: controller.addWordStatus == AddWordStatus.loading
                ? true
                : false,
          );
        }),
      ]),
    );
  }
}
