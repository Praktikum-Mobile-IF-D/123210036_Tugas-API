import 'package:hive/hive.dart';

part 'user.g.dart'; // Generate Hive TypeAdapter

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  late String email;

  @HiveField(1)
  late String password;

  @HiveField(2)
  late String birthdate;

  User(this.email, this.password, this.birthdate);
}
