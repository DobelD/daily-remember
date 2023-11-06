import 'package:dailyremember/presentation/add_word/section/app_bar_add_word.dart';
import 'package:dailyremember/presentation/add_word/section/form.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/add_word.controller.dart';

class AddWordScreen extends GetView<AddWordController> {
  const AddWordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarAddWord,
        body: const SingleChildScrollView(
          child: FormSection(),
        ));
  }
}
