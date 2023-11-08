import 'package:dailyremember/components/app_snackbar.dart';
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
    bool validatedForm = nameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
    bool validatedPassword =
        passwordController.text == confirmPasswordController.text;
    var param = RegisterParam(
        name: nameController.text,
        username: usernameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        password: passwordController.text);
    // ignore: unnecessary_null_comparison
    if (validatedForm) {
      if (validatedPassword) {
        final res = await _authRepository.registerWithApi(param);
        if (res != null) {
          nameController.clear();
          usernameController.clear();
          emailController.clear();
          phoneNumberController.clear();
          confirmPasswordController.clear();
          registerStatus(RegisterStatus.success);
          AppSnackbar.success(message: "Success registered account!");
        }
        registerStatus(RegisterStatus.failed);
      } else {
        AppSnackbar.error(message: "Password not same");
        registerStatus(RegisterStatus.failed);
      }
    } else {
      AppSnackbar.error(message: "All field is required!");
      registerStatus(RegisterStatus.failed);
    }
  }
}
