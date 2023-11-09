class UserParam {
  UserParam(
      {this.id,
      this.name,
      this.username,
      this.avatar,
      this.email,
      this.phoneNumber});
  int? id;
  String? name;
  String? username;
  String? avatar;
  String? email;
  String? phoneNumber;

  Map<String, dynamic> toMap() => {
        'name': name,
        'username': username,
        'avatar': avatar,
        'email': email,
        'phone_number': phoneNumber
      };
}
