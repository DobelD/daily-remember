import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:dailyremember/domain/core/interfaces/transcribe_repository.dart';

import '../../../utils/constant.dart';

class TranscribeRepositoryImpl implements TranscribeRepository {
  @override
  Future<String?> transcribeAudio(String path, String name) async {
    Dio dio = Dio();
    String apiKey = apiKeySpeech;
    try {
      FormData formData = FormData.fromMap({
        'data_file': await MultipartFile.fromFile(path, filename: name),
        'config': jsonEncode({
          'type': 'transcription',
          'transcription_config': {
            'operating_point': 'enhanced',
            'language': 'en'
          }
        }),
      });

      final response = await dio.post(
        'https://asr.api.speechmatics.com/v2/jobs/',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );

      if (response.statusCode == 201) {
        return response.data['id'];
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioException) {
        log(e.response?.data);
      }
      return null;
    }
  }

  @override
  Future<String?> getTranscribeAudio(String id) async {
    Dio dio = Dio();
    String apiKey = apiKeySpeech;
    try {
      final response = await dio.get(
        'https://asr.api.speechmatics.com/v2/jobs/$id/transcript?format=txt',
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioException) {
        log(e.response?.data);
      }
      return null;
    }
  }

  @override
  Future<String?> deleteTranscribeAudio(String id) async {
    Dio dio = Dio();
    String apiKey = apiKeySpeech;
    try {
      final response = await dio.delete(
        'https://asr.api.speechmatics.com/v2/jobs/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data['job']['status'];
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioException) {
        log(e.response?.data);
      }
      return null;
    }
  }
}
