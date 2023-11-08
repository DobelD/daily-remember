import 'package:dailyremember/components/app_snackbar.dart';
import 'package:dailyremember/domain/core/interfaces/auth_repository.dart';
import 'package:dailyremember/infrastructure/navigation/routes.dart';
import 'package:dailyremember/utils/preference/app_preference.dart';
import 'package:get/get.dart';

enum AccountStatus { initial, loading, success, failed }

class AccountController extends GetxController {
  final AuthRepository _authRepository;
  AccountController(this._authRepository);

  var accountStatus = Rx<AccountStatus>(AccountStatus.initial);

  Future<void> logout() async {
    final token = AppPreference().getAccessToken();
    accountStatus(AccountStatus.loading);
    final res = await _authRepository.logout(token ?? '');
    if (res == true) {
      accountStatus(AccountStatus.success);
      AppPreference().clearLocalStorage();
      Get.offAllNamed(Routes.LOGIN);
    } else {
      accountStatus(AccountStatus.failed);
      AppSnackbar.error(message: 'Logout failed');
    }
  }
}
