class RegisterParam {
  const RegisterParam({
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  final String name;
  final String username;
  final String email;
  final String phoneNumber;
  final String password;

  Map<String, dynamic> toMap() => {
        'name': name,
        'username': username,
        'email': email,
        'phone_number': phoneNumber,
        'password': password,
      };
}
