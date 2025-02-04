import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class EditProfilePage extends StatelessWidget {
  final UserController userController = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = userController.user.value!;
    nameController.text = user.name;
    addressController.text = user.address;
    mobileController.text = user.mobileNo;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gradient Header
            Container(
              width: double.infinity,
              height: 15.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(user.image),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),

            // Profile Edit Form
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    children: [
                      _buildTextField(Icons.person, "Name", nameController),
                      _buildTextField(Icons.location_on, "Address", addressController),
                      _buildTextField(Icons.phone, "Mobile No", mobileController, keyboardType: TextInputType.phone),
                      SizedBox(height: 3.h),

                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          final updatedUser = UserModel(
                            email: user.email,
                            name: nameController.text,
                            address: addressController.text,
                            mobileNo: mobileController.text,
                            image: user.image,
                          );
                          userController.updateUser(updatedUser);
                          Get.back();
                        },
                        icon: const Icon(Icons.save, color: Colors.white),
                        label: const Text(
                          "Save Changes",
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
      ),
    );
  }

  Widget _buildTextField(IconData icon, String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          labelText: label,
          labelStyle: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}
