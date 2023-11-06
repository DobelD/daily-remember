import 'package:dailyremember/components/app_button.dart';
import 'package:dailyremember/components/app_form.dart';
import 'package:dailyremember/presentation/home/controllers/home.controller.dart';
import 'package:dailyremember/presentation/speaking/controllers/speaking.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTarget extends StatelessWidget {
  const AddTarget({super.key, this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            AppForm(
              controller: controller.targetController,
              hintText: "Masukkan target",
              keyboardType: TextInputType.number,
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
