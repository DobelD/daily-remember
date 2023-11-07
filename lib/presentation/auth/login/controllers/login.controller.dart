import 'package:dailyremember/domain/core/interfaces/auth_repository.dart';
import 'package:dailyremember/domain/core/model/params/login_param.dart';
import 'package:dailyremember/domain/core/model/params/register_param.dart';
import 'package:dailyremember/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LoginStatus { initial, loading, success, failed }

class LoginController extends GetxController {
  final AuthRepository _authRepository;
  LoginController(this._authRepository);

  var loginStatus = Rx<LoginStatus>(LoginStatus.initial);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> loginWithApi() async {
    loginStatus(LoginStatus.loading);
    var param = LoginParam(
        email: emailController.text, password: passwordController.text);
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      final res = await _authRepository.login(param);
      if (res != null && res == true) {
        loginStatus(LoginStatus.success);
        Get.offAllNamed(Routes.MAIN_PAGE);
      }
      loginStatus(LoginStatus.failed);
    }
    loginStatus(LoginStatus.failed);
  }

  Future<void> loginWithFingerprint() async {
    if (loginStatus.value != LoginStatus.loading) {}
  }

  Future<void> loginWithGoogle() async {
    if (loginStatus.value != LoginStatus.loading) {}
  }

  Future<void> loginWithFacebook() async {
    if (loginStatus.value != LoginStatus.loading) {}
  }

  Future<void> forgotPassword() async {
    if (loginStatus.value != LoginStatus.loading) {}
  }
}
