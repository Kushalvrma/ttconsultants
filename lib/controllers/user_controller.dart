import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';
import '../services/hive_service.dart';

class UserController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  final HiveService _hiveService = HiveService();

  Rx<UserModel?> user = Rx<UserModel?>(null);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    isLoading.value = true;

    UserModel? localUser = await _hiveService.getUser();
    if (localUser != null) {
      print("Fetched from Hive: $localUser");
      user.value = localUser;
    } else {
      print("No user found in Hive.");
    }

    UserModel? firebaseUser = await _firebaseService.fetchUser();
    if (firebaseUser != null) {
      print("Fetched from Firebase: $firebaseUser");
    }

    if (firebaseUser != null && firebaseUser.toMap() != localUser?.toMap()) {
      await _hiveService.saveUser(firebaseUser);
      user.value = firebaseUser;
      print("Updated Hive with Firebase data.");
    }

    isLoading.value = false;
  }

  Future<void> updateUser(UserModel updatedUser) async {
    await _firebaseService.updateUser(updatedUser);
    await _hiveService.saveUser(updatedUser);
    user.value = updatedUser;
  }
}
