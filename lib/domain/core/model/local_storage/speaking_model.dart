import 'package:hive/hive.dart';

part 'speaking_model.g.dart';

@HiveType(typeId: 0)
class SpeakingModel extends HiveObject {
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String audioPath;
  @HiveField(2)
  late String duration;
  @HiveField(3)
  late String createdAt;
  SpeakingModel(this.title, this.audioPath, this.duration, this.createdAt);
}
