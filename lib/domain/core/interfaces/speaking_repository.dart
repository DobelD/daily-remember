import '../model/params/speaking_param.dart';
import '../model/speaking_model.dart';

abstract class SpeakingRepository {
  Future<List<SpeakingModel>?> getSpeaking();
  Future<SpeakingModel?> createdSpeaking(SpeakingParam param);
  Future<bool?> addTranscribeToSpeaking(int id, String idTranscribe);
  Future<String?> deleteSpeaking(int id, String isTranscribe);
}
