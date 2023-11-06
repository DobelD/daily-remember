import 'package:dailyremember/domain/core/interfaces/word_repository.dart';
import 'package:dailyremember/domain/core/model/word_model.dart';
import 'package:dailyremember/domain/core/model/word_param.dart';

import '../daos/provider/remote/remote_provider.dart';

class WordRepositoryImpl implements WordRepository {
  WordRepositoryImpl() {
    RemoteProvider.init();
  }

  @override
  Future<List<WordModel>?> getWord() async {
    try {
      final response = await RemoteProvider.client.get('word');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((e) => WordModel.fromJson(e)).toList();
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  @override
  Future<List<WordModel>?> createWord(WordParam param) async {
    try {
      final response =
          await RemoteProvider.client.post('word', data: param.toMap());

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((e) => WordModel.fromJson(e)).toList();
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  @override
  Future<List<WordModel>?> updateWord(WordParam param, int id) async {
    try {
      final response =
          await RemoteProvider.client.put('word/$id', data: param.toMap());

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((e) => WordModel.fromJson(e)).toList();
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  @override
  Future<int?> deleteWord(int id) async {
    try {
      final response = await RemoteProvider.client.delete('word/$id');

      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
