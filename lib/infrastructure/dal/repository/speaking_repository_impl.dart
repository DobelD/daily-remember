import 'package:dailyremember/domain/core/interfaces/speaking_repository.dart';
import 'package:dio/dio.dart';

import '../../../domain/core/model/params/speaking_param.dart';
import '../../../domain/core/model/speaking_model.dart';
import '../daos/provider/remote/remote_provider.dart';

class SpeakingRepositoryImpl implements SpeakingRepository {
  SpeakingRepositoryImpl() {
    RemoteProvider.init();
  }
  @override
  Future<List<SpeakingModel>?> getSpeaking() async {
    try {
      final response = await RemoteProvider.client.get('speaking');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((e) => SpeakingModel.fromJson(e)).toList();
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  @override
  Future<SpeakingModel?> createdSpeaking(SpeakingParam param) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(param.audioPath ?? '',
            filename: param.title),
        'title': param.title,
        'audio_path': param.audioPath,
        'duration': param.duration
      });
      final response =
          await RemoteProvider.client.post('speaking', data: formData);

      if (response.statusCode == 200) {
        return SpeakingModel.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (error) {
      if (error is DioException) {
        print(error.response?.data);
      }
      return null;
    }
  }

  @override
  Future<bool?> addTranscribeToSpeaking(int id, String idTranscribe) async {
    try {
      final response =
          await RemoteProvider.client.put('transcribe/$id/$idTranscribe');
      print(response.data);
      if (response.data['status_code'] == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  @override
  Future<String?> deleteSpeaking(int id, String idTranscribe) async {
    try {
      final response =
          await RemoteProvider.client.delete('speaking/$id/$idTranscribe');
      if (response.statusCode == 200) {
        return "Berhasil";
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
