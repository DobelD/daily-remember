class UserModel {
  int? id;
  String? name;
  String? username;
  String? avatar;
  String? email;
  String? phoneNumber;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.name,
      this.username,
      this.avatar,
      this.email,
      this.phoneNumber,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    avatar = json['avatar'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['avatar'] = avatar;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
