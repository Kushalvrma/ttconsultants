import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String mobileNo;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final String image;

  UserModel({
    required this.email,
    required this.name,
    required this.mobileNo,
    required this.address,
    required this.image,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      name: map['name'],
      mobileNo: map['mobile_no'],
      address: map['address'],
      image: map['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'mobile_no': mobileNo,
      'address': address,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, mobileNo: $mobileNo, address: $address, image: $image)';
  }
}
