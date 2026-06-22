import 'package:foodexpress_mobile/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);

  Future<UserEntity> register(
    String name,
    String email,
    String password,
    int roleId,
    String otpToken,
  );
}
