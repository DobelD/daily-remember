import 'package:dailyremember/components/app_bottom_sheet.dart';
import 'package:dailyremember/components/app_snackbar.dart';
import 'package:dailyremember/domain/core/interfaces/auth_repository.dart';
import 'package:dailyremember/domain/core/interfaces/progress_repository.dart';
import 'package:dailyremember/domain/core/model/params/progress_param.dart';
import 'package:dailyremember/domain/core/model/progress_model.dart';
import 'package:dailyremember/domain/core/model/user_model.dart';
import 'package:dailyremember/infrastructure/navigation/routes.dart';
import 'package:dailyremember/presentation/account/widget/progress_target.dart';
import 'package:dailyremember/utils/preference/app_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

import '../../../components/waiting_progress.dart';
import '../../../infrastructure/theme/typography.dart';
import '../widget/add_target.dart';

enum AccountStatus { initial, loading, success, failed }

class AccountController extends GetxController {
  final AuthRepository _authRepository;
  final ProgressRepository _progressRepository;
  AccountController(this._authRepository, this._progressRepository);

  TextEditingController targetController = TextEditingController();
  TextEditingController targetRememberPerdayController =
      TextEditingController();

  var accountStatus = Rx<AccountStatus>(AccountStatus.initial);
  var userProfile = UserModel();
  var progressUser = ProgressModel();

  late CacheManager customCacheManager;

  Future<void> logout() async {
    AppPreference().clearLocalStorage();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> getUserProfile() async {
    accountStatus(AccountStatus.loading);
    final res = await _authRepository.userProfile();
    if (res != null) {
      userProfile = res;
      update();
      accountStatus(AccountStatus.success);
    } else {
      accountStatus(AccountStatus.failed);
    }
  }

  Future<void> getProgress() async {
    final res = await _progressRepository.getProgress();
    if (res != null) {
      progressUser = res;
      update();
    }
  }

  void progress() {
    if (progressUser.targetDay == null) {
      targetController =
          TextEditingController(text: "${progressUser.targetDay ?? ''}");
      targetRememberPerdayController = TextEditingController(
          text: "${progressUser.targetRememberPerday ?? ''}");
      Get.defaultDialog(
          title: "Buat target hafalan harian!",
          titleStyle: titleBold,
          radius: 8,
          content: AddTarget(
            onPressed: () => addTarget(targetController.text,
                targetRememberPerdayController.text, false),
          )).whenComplete(() {
        targetController.clear();
        targetRememberPerdayController.clear();
      });
    } else {
      Get.bottomSheet(
          enterBottomSheetDuration: 400.milliseconds,
          exitBottomSheetDuration: 400.milliseconds,
          AppBottomSheet(
              title: "Progress Target",
              textButton: "Complited",
              onPressed:
                  progressUser.achieved == progressUser.targetRememberPerday
                      ? () => addTarget("0", "0", true)
                      : null,
              child: ProgressTarget(data: progressUser)));
    }
  }

  Future<void> addTarget(
      String targetDay, String targetrRememberPerday, bool isComplite) async {
    var param = ProgressParam(
        targetDay: int.parse(targetDay),
        targetrRememberPerday: int.parse(targetrRememberPerday));
    Get.back();
    WaitingProgress.init(
        title: isComplite ? "Complited Remember" : "Menambahkan target");
    final res = await _progressRepository.updateProgress(param, userProfile.id);
    if (res != null) {
      getProgress();
      Get.back();
      if (isComplite) {
      } else {
        AppSnackbar.success(message: "Success add target");
      }
    } else {
      AppSnackbar.error(
          message: isComplite ? "Failed complite target" : "Failed add target");
      Get.back();
    }
  }

  @override
  void onInit() {
    getUserProfile();
    getProgress();
    customCacheManager = CacheManager(Config('customCacheKey',
        stalePeriod: 15.days, maxNrOfCacheObjects: 100));
    super.onInit();
  }
}
