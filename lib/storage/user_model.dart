import 'package:hive/hive.dart';
import './metas_controller.dart'; // Assuming you have imported the Meta class

part 'user.g.dart'; // Hive-generated file

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String email;

  @HiveField(2)
  String password;

  @HiveField(3)
  int puntos;

  @HiveField(4)
  List<Meta> metas; // This may require implementing a custom adapter if Meta is complex

  @HiveField(5)
  DateTime? dateTime;

  User(this.username, this.email, this.password, {this.puntos = 0, this.metas = const []});
}
