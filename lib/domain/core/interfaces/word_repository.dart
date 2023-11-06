import 'package:dailyremember/domain/core/model/word_model.dart';
import 'package:dailyremember/domain/core/model/word_param.dart';

abstract class WordRepository {
  Future<List<WordModel>?> getWord();
  Future<List<WordModel>?> createWord(WordParam param);
  Future<List<WordModel>?> updateWord(WordParam param, int id);
  Future<int?> deleteWord(int id);
}
