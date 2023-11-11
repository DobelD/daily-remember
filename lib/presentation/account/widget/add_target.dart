import 'package:dailyremember/components/app_button.dart';
import 'package:dailyremember/components/app_form.dart';
import 'package:dailyremember/presentation/account/controllers/account.controller.dart';
import 'package:dailyremember/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTarget extends StatelessWidget {
  const AddTarget({super.key, this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountController>();
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            AppForm(
              controller: controller.targetController,
              hintText: "Masukkan target hari",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 12,
            ),
            AppForm(
              controller: controller.targetRememberPerdayController,
              hintText: "Masukkan target hafalan per hari",
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
