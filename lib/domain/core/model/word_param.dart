class WordParam {
  const WordParam({
    required this.indonesia,
    this.remember = false,
    this.verbOne,
    this.verbTwo,
    this.verbThree,
    this.verbIng,
  });

  final String indonesia;
  final bool remember;
  final String? verbOne;
  final String? verbTwo;
  final String? verbThree;
  final String? verbIng;

  Map<String, dynamic> toMap() => {
        'indonesia': indonesia,
        'remember': remember,
        'verb_one': verbOne,
        'verb_two': verbTwo,
        'verb_three': verbThree,
        'verb_ing': verbIng
      };
}
