import 'package:dailyremember/domain/core/interfaces/auth_repository.dart';
import 'package:dailyremember/domain/core/interfaces/progress_repository.dart';
import 'package:dailyremember/domain/core/model/progress_model.dart';
import 'package:dailyremember/domain/core/model/user_model.dart';
import 'package:dailyremember/infrastructure/navigation/routes.dart';
import 'package:dailyremember/utils/preference/app_preference.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

enum AccountStatus { initial, loading, success, failed }

class AccountController extends GetxController {
  final AuthRepository _authRepository;
  final ProgressRepository _progressRepository;
  AccountController(this._authRepository, this._progressRepository);

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

  @override
  void onInit() {
    getUserProfile();
    getProgress();
    customCacheManager = CacheManager(Config('customCacheKey',
        stalePeriod: 15.days, maxNrOfCacheObjects: 100));
    super.onInit();
  }
}
