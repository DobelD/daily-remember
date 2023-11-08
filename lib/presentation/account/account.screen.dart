import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/account.controller.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AccountScreen'),
        centerTitle: true,
      ),
      body: Center(
          child: IconButton(
              onPressed: () => controller.logout(),
              icon: const Icon(Icons.logout_rounded))),
    );
  }
}
