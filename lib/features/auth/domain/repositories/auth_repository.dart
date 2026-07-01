import 'package:dartz/dartz.dart';
import 'package:foodexpress_mobile/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, void>> sendOtp(String email);
  Future<Either<String, String>> verifyOtp(String email, String code);
  Future<Either<String, void>> register(
    String name,
    String email,
    String password,
    String phone,
    int roleId,
    String otpToken,
  );
  Future<Either<String, void>> login(String email, String password);
  Future<Either<String, UserEntity>> getMe();
  Future<void> logout();
}
