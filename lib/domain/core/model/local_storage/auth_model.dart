import 'package:hive/hive.dart';

part 'auth_model.g.dart';

@HiveType(typeId: 2)
class AuthModel extends HiveObject {
  @HiveField(0)
  late String email;
  @HiveField(1)
  late String password;
  AuthModel(this.email, this.password);
}
