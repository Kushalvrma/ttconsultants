import 'package:hive/hive.dart';
import '../models/user_model.dart';

class HiveService {
  static const String _boxName = "userBox";

  Future<void> saveUser(UserModel user) async {
    var box = await Hive.openBox<UserModel>(_boxName);
    await box.put("user", user);
  }

  Future<UserModel?> getUser() async {
    var box = await Hive.openBox<UserModel>(_boxName);
    return box.get("user");
  }
}
