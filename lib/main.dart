import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:ttconsultants/controllers/user_controller.dart';
import 'package:ttconsultants/models/user_model.dart';
import 'package:ttconsultants/views/profile_page.dart'; // Import your ProfilePage

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  // Register the adapter for UserModel
  Hive.registerAdapter(UserModelAdapter());

  await Hive.openBox<UserModel>('userBox');  // Open the Hive box

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // Using the ProfilePage as the initial page
          home: ProfilePage(),
        );
      },
    );
  }
}
