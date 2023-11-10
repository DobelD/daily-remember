class ProgressParam {
  const ProgressParam({
    required this.targetDay,
    required this.targetrRememberPerday,
  });

  final String targetDay;
  final String targetrRememberPerday;

  Map<String, dynamic> toMap() => {
        'target_day': targetDay,
        'target_remember_perday': targetrRememberPerday,
      };
}
