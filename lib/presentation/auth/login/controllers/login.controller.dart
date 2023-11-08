import 'dart:developer';

import 'package:dailyremember/components/app_snackbar.dart';
import 'package:dailyremember/domain/core/interfaces/auth_repository.dart';
import 'package:dailyremember/domain/core/model/local_storage/auth_model.dart';
import 'package:dailyremember/domain/core/model/params/login_param.dart';
import 'package:dailyremember/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';

enum LoginStatus { initial, loading, waiting, success, failed }

enum SupportState {
  unknown,
  supported,
  unsupported,
}

class LoginController extends GetxController {
  final AuthRepository _authRepository;
  LoginController(this._authRepository);

  var loginStatus = Rx<LoginStatus>(LoginStatus.initial);
  var authData = <AuthModel>[].obs;
  LocalAuthentication biomatricAuth = LocalAuthentication();
  var supportState = Rx<SupportState>(SupportState.unknown);

  final FocusNode focusNode = FocusNode();
  final GlobalKey autocompleteKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var rememberMe = false.obs;

  Future<void> saveAuthData(AuthModel data) async {
    var box = await Hive.openBox<AuthModel>('auth');
    await box.put('authData', data);
  }

  Future<void> loginWithApi() async {
    loginStatus(LoginStatus.loading);
    bool validated =
        passwordController.text.isNotEmpty && emailController.text.isNotEmpty;
    var param = LoginParam(
        email: emailController.text, password: passwordController.text);
    if (validated) {
      final res = await _authRepository.login(param);
      if (res != null && res == true) {
        loginStatus(LoginStatus.success);
        if (rememberMe.value) {
          var authData = AuthModel(param.email, param.password);
          saveAuthData(authData);
        }
        Get.offAllNamed(Routes.MAIN_PAGE);
      }
      loginStatus(LoginStatus.failed);
    } else {
      AppSnackbar.error(message: "Email and Password is required!");
    }
    loginStatus(LoginStatus.failed);
  }

  Future<void> loginWithFingerprint() async {
    if (loginStatus.value != LoginStatus.loading) {
      if (authData.isNotEmpty) {
        bool authenticated = false;
        try {
          authenticated = await biomatricAuth.authenticate(
            localizedReason: 'Scan your fingerprint  to authenticate',
            options: const AuthenticationOptions(
              useErrorDialogs: true,
              stickyAuth: true,
              biometricOnly: true,
            ),
          );

          if (authenticated) {
            loginStatus(LoginStatus.waiting);
            var param = LoginParam(
                email: authData[0].email, password: authData[0].password);
            final res = await _authRepository.login(param);
            if (res == true) {
              loginStatus(LoginStatus.success);
              Get.offAllNamed(Routes.MAIN_PAGE);
            }
            loginStatus(LoginStatus.failed);
          }
        } on PlatformException catch (e) {
          log(e.toString());
          return;
        }
        if (!isClosed) {
          return;
        }
      } else {
        AppSnackbar.error(message: "Login again!");
      }
    }
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

  // Remember me

  void chengeRemember(bool? remember) {
    rememberMe.value = remember ?? false;
  }

  // Init State

  Future<void> loadAuthData() async {
    var box = await Hive.openBox<AuthModel>('auth');
    final data = box.get('authData');
    authData.add(data!);
    update();
  }

  void selectedEmail(AuthModel value) {
    emailController = TextEditingController(text: value.email);
    passwordController = TextEditingController(text: value.password);
    update();
  }

  @override
  void onInit() {
    loadAuthData();
    biomatricAuth.isDeviceSupported().then((bool isSupported) {
      // ignore: unrelated_type_equality_checks
      if (isSupported) {
        supportState(SupportState.supported);
      } else {
        supportState(SupportState.unsupported);
      }
    });
    super.onInit();
  }
}
