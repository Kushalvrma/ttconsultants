import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/user_controller.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = userController.user.value;
        if (user == null) {
          return const Center(child: Text("No user data found"));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 20.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: NetworkImage(user.image),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          user.email,
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 3.h),

                        _buildInfoTile(Icons.phone, "Mobile", user.mobileNo),
                        _buildInfoTile(Icons.location_on, "Address", user.address),

                        SizedBox(height: 2.h),

                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => Get.to(() => EditProfilePage()),
                          icon: const Icon(Icons.edit, color: Colors.white),
                          label: const Text(
                            "Edit Profile",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 22.sp),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              "$title: $value",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
