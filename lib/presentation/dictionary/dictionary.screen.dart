import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/dictionary.controller.dart';

class DictionaryScreen extends GetView<DictionaryController> {
  const DictionaryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DictionaryScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DictionaryScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
