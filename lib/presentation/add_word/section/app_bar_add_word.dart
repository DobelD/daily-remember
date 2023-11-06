import 'package:dailyremember/infrastructure/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar get appBarAddWord {
  return AppBar(
    backgroundColor: Colors.blueAccent,
    automaticallyImplyLeading: false,
    title: Text(
        '${Get.arguments['type'] != "update" ? "Add Word" : "Edit Word"} and start momorize',
        style: whiteTitleBold),
    elevation: 1,
    centerTitle: true,
  );
}
