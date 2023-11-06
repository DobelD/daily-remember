class WordParam {
  const WordParam({
    required this.indonesia,
    required this.english,
    this.remember = false,
    this.verbOne,
    this.verbTwo,
    this.verbThree,
    this.verbIng,
  });

  final String indonesia;
  final String english;
  final bool remember;
  final String? verbOne;
  final String? verbTwo;
  final String? verbThree;
  final String? verbIng;

  Map<String, dynamic> toMap() => {
        'indonesia': indonesia,
        'english': english,
        'remember': remember,
        'verb_one': verbOne,
        'verb_two': verbTwo,
        'verb_three': verbThree,
        'verb_ing': verbIng
      };
}
