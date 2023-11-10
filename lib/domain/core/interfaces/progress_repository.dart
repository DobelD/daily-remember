import 'package:dailyremember/domain/core/model/params/progress_param.dart';
import 'package:dailyremember/domain/core/model/progress_model.dart';

abstract class ProgressRepository {
  Future<ProgressModel?> getProgress();
  Future<bool?> updateProgress(ProgressParam param, int? id);
}
