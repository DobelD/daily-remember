class ProgressModel {
  int? userId;
  int? totalWord;
  int? remember;
  int? noRemember;
  int? targetDay;
  int? targetRememberPerday;
  int? achieved;
  int? runningDay;

  ProgressModel(
      {this.userId,
      this.totalWord,
      this.remember,
      this.noRemember,
      this.targetDay,
      this.targetRememberPerday,
      this.achieved,
      this.runningDay});

  ProgressModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    totalWord = json['total_word'];
    remember = json['remember'];
    noRemember = json['no_remember'];
    targetDay = json['target_day'];
    targetRememberPerday = json['target_remember_perday'];
    achieved = json['achieved'];
    runningDay = json['running_day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['total_word'] = totalWord;
    data['remember'] = remember;
    data['no_remember'] = noRemember;
    data['target_day'] = targetDay;
    data['target_remember_perday'] = targetRememberPerday;
    data['achieved'] = achieved;
    data['running_day'] = runningDay;
    return data;
  }
}
