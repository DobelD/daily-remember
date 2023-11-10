import 'package:dailyremember/domain/core/interfaces/progress_repository.dart';
import 'package:dailyremember/domain/core/model/progress_model.dart';
import 'package:dailyremember/infrastructure/dal/daos/provider/remote/remote_provider.dart';

import '../../../domain/core/model/params/progress_param.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  ProgressRepositoryImpl() {
    RemoteProvider.init();
  }

  @override
  Future<ProgressModel?> getProgress() async {
    try {
      final response = await RemoteProvider.client.get('progress-vocabulary');
      if (response.statusCode == 200) {
        return ProgressModel.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool?> updateProgress(ProgressParam param, int? id) async {
    try {
      final response = await RemoteProvider.client
          .put('progress-vocabulary/$id', data: param.toMap());
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
