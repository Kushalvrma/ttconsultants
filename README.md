1. Prerequisites
   Before you begin, ensure you have the following installed:

   Flutter: Install Flutter
   Firebase Project: Create a Firebase Project
   Android Studio / VS Code or any IDE for Flutter development
   A device/emulator for testing (Android or iOS)

2. Clone the Repository
   git clone https://github.com/your-repository-link.git
   cd your-project-directory

3. Install Dependencies
   flutter pub get
4. Firebase Setup
   a. Create a Firebase Project
   Go to Firebase Console, create a new project, and follow the setup instructions for your platform (Android/iOS).

   b. Add Firebase to Your Flutter App
   For Android:
   In your Firebase project, navigate to Project Settings and add an Android app.
   Download the google-services.json file and place it in the android/app directory of your Flutter project.
   Modify the android/build.gradle and android/app/build.gradle files as instructed in the Firebase setup guide.
   For iOS (if you're building for iOS):
   Add the GoogleService-Info.plist to the ios/Runner directory and modify the ios/Runner/Info.plist as instructed in the Firebase setup guide.

   c. Enable Firestore in Firebase Console
   In the Firebase Console, go to Firestore and enable Firestore for your app.
   Set up the Firestore security rules.
   rules_version = '2';
   service cloud.firestore {
   match /databases/{database}/documents {
   match /{document=**} {
   allow read, write: if true;  // For development purposes, modify as needed
   }
   }
   }


5. Hive Setup
6. Register Hive Model Adapter
   import 'package:hive_flutter/hive_flutter.dart';
   import 'package:ttconsultants/models/user_model.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
await Hive.initFlutter();

// Register the adapter for UserModel
Hive.registerAdapter(UserModelAdapter());

await Hive.openBox<UserModel>('userBox');  // Open the Hive box

runApp(const MyApp());
}


7. Create Firestore Collection
   Make sure you have a Firestore collection named users, with documents that have the following fields:

Field Name	Type	Example Value
email	String	john.doe@example.com
mobile_no	String	+91 9876543210
address	String	123, Delhi, India
image	String	https://example.com/user.jpg
name	String	John Doe

8. Running the App
   Ensure Android/iOS Emulator is Running: Make sure your emulator is running or your device is connected.
   Run the App: Run the app using flutter run:

   flutter run