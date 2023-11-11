class SpeakingParam {
  const SpeakingParam(
      {this.title, this.audioPath, this.duration, this.transcribe});

  final String? title;
  final String? audioPath;
  final String? duration;
  final String? transcribe;

  Map<String, dynamic> toMap() => {
        'title': title,
        'audio_path': audioPath,
        'duration': duration,
        "transcript": transcribe,
      };
}
