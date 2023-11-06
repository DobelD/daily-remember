import 'package:hive/hive.dart';

part 'vocabulary.g.dart';

@HiveType(typeId: 0)
class VocabularyModel extends HiveObject {
  @HiveField(0)
  late String verbOne;
  @HiveField(1)
  late String verbTwo;
  @HiveField(2)
  late String verbThree;
  @HiveField(3)
  late String verbIng;
  VocabularyModel(this.verbOne, this.verbTwo, this.verbThree, this.verbIng);
}
