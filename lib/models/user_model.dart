import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  String email;

  @HiveField(1)
  String password;

  @HiveField(2)
  String? name;

  User({
    required this.email,
    required this.password,
     this.name,
  });
}