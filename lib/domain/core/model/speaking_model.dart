class SpeakingModel {
  int? id;
  String? title;
  String? audioPath;
  String? idTranscript;
  String? transcript;
  String? duration;
  int? userId;
  String? createdAt;
  String? updatedAt;

  SpeakingModel(
      {this.id,
      this.title,
      this.audioPath,
      this.idTranscript,
      this.transcript,
      this.duration,
      this.userId,
      this.createdAt,
      this.updatedAt});

  SpeakingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    audioPath = json['audio_path'];
    idTranscript = json['id_transcript'];
    transcript = json['transcript'];
    duration = json['duration'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['audio_path'] = audioPath;
    data['id_transcript'] = idTranscript;
    data['transcript'] = transcript;
    data['duration'] = duration;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
