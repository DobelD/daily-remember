abstract class TranscribeRepository {
  Future<String?> transcribeAudio(String path, String name);
  Future<String?> getTranscribeAudio(String id);
  Future<String?> deleteTranscribeAudio(String id);
}
