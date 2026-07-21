import 'package:foodexpress_mobile/infrastructure/models/user/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.email, required super.name, required super.role, super.phoneNumber});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final customer = json["CUSTOMER"] ?? {};
    return UserModel(
      id: json["user_id"],
      email: json["email"],
      role: json["role"],
      name: customer["name"] ?? "Mijoz",
      phoneNumber: customer["phone_number"],
    );
  }
}
