import 'package:dailyremember/domain/core/interfaces/auth_repository.dart';
import 'package:dailyremember/domain/core/model/params/register_param.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum RegisterStatus { initial, loading, success, failed }

class RegisterController extends GetxController {
  final AuthRepository _authRepository;
  RegisterController(this._authRepository);

  var registerStatus = Rx<RegisterStatus>(RegisterStatus.initial);

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> registerWithApi() async {
    registerStatus(RegisterStatus.loading);
    var param = RegisterParam(
        name: nameController.text,
        username: usernameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        password: passwordController.text);
    if (passwordController.text == confirmPasswordController.text) {
      final res = await _authRepository.registerWithApi(param);
      if (res != null) {
        registerStatus(RegisterStatus.success);
      }
      registerStatus(RegisterStatus.failed);
    }
    registerStatus(RegisterStatus.failed);
  }
}
