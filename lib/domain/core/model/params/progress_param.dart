class ProgressParam {
  const ProgressParam({
    required this.targetDay,
    required this.targetrRememberPerday,
  });

  final int targetDay;
  final int targetrRememberPerday;

  Map<String, dynamic> toMap() => {
        'target_day': targetDay == 0 ? null : targetDay,
        'target_remember_perday':
            targetrRememberPerday == 0 ? null : targetrRememberPerday,
      };
}
