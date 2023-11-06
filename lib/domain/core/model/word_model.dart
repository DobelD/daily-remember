class WordModel {
  int? id;
  String? indonesia;
  String? english;
  bool? remember;
  String? verbOne;
  String? verbTwo;
  String? verbThree;
  String? verbIng;
  String? createdAt;
  String? updatedAt;

  WordModel(
      {this.id,
      this.indonesia,
      this.english,
      this.remember,
      this.verbOne,
      this.verbTwo,
      this.verbThree,
      this.verbIng,
      this.createdAt,
      this.updatedAt});

  WordModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    indonesia = json['indonesia'];
    english = json['english'];
    remember = json['remember'];
    verbOne = json['verb_one'];
    verbTwo = json['verb_two'];
    verbThree = json['verb_three'];
    verbIng = json['verb_ing'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['indonesia'] = indonesia;
    data['english'] = english;
    data['remember'] = remember;
    data['verb_one'] = verbOne;
    data['verb_two'] = verbTwo;
    data['verb_three'] = verbThree;
    data['verb_ing'] = verbIng;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
