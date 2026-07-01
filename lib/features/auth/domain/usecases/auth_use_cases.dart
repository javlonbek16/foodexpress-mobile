import 'package:dartz/dartz.dart';
import 'package:foodexpress_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:foodexpress_mobile/features/auth/domain/repositories/auth_repository.dart';

class AuthUseCases {
  final AuthRepository repository;
  AuthUseCases(this.repository);

  Future<Either<String, void>> login(String email, String password) =>
      repository.login(email, password);

  Future<Either<String, void>> sendOtp(String email) => repository.sendOtp(email);

  Future<Either<String, String>> verifyOtp(String email, String code) =>
      repository.verifyOtp(email, code);

  Future<Either<String, void>> register(
    String name,
    String email,
    String password,
    String phone,
    int roleId,
    String otpToken,
  ) => repository.register(name, email, password, phone, roleId, otpToken);

  Future<Either<String, UserEntity>> getMe() => repository.getMe();
}
