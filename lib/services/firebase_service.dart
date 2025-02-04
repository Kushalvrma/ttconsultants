import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> fetchUser() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection('users').doc('user1').get();
      if (snapshot.exists) {
        return UserModel.fromMap(snapshot.data()!);
      } else {
        print("No user found in Firebase.");
        return null;
      }
    } catch (e) {
      print("Error fetching user from Firebase: $e");
      return null;
    }
  }

  Future<void> updateUser(UserModel user) async {
    await _firestore.collection("users").doc("user1").set(user.toMap());
  }

  Future<void> saveUser(UserModel user) async {
    var box = await Hive.openBox<UserModel>('userBox');
    await box.put('user', user);
    print("Saved user to Hive: $user");
  }

  Future<UserModel?> getUser() async {
    var box = await Hive.openBox<UserModel>('userBox');
    return box.get('user');
  }

}
