import 'package:dartz/dartz.dart';
import 'package:foodexpress_mobile/core/local/secure_storage_service.dart';
import 'package:foodexpress_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:foodexpress_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:foodexpress_mobile/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final SecureStorageService secureStorageService;

  AuthRepositoryImpl(this.remote, this.secureStorageService);

  @override
  Future<Either<String, void>> login(String email, String password) async {
    try {
      final response = await remote.login(email, password);
      await secureStorageService.saveAccessToken(response["access_token"]);
      await secureStorageService.saveRefreshToken(response["refresh_token"]);
      await secureStorageService.saveUserId(response["user_id"].toString());
      return const Right(null);
    } catch (e) {
      return Left("Xatolik: E-mail yoki parol noto'g'ri\nError: $e");
    }
  }

  @override
  Future<Either<String, void>> sendOtp(String email) async {
    try {
      await remote.sendOtp(email);
      return const Right(null);
    } catch (e, s) {
      return Left("Kodni yuborishda xatolik: $s");
    }
  }

  @override
  Future<Either<String, String>> verifyOtp(String email, String code) async {
    try {
      final token = await remote.verifyOtp(email, code);
      return Right(token);
    } catch (e) {
      return Left("Kod noto'g'ri");
    }
  }

  @override
  Future<Either<String, void>> register(
    String name,
    String email,
    String password,
    String phone,
    int roleId,
    String otpToken,
  ) async {
    try {
      await remote.register({
        "name": name,
        "email": email,
        "password": password,
        "phone_number": phone,
        "role_id": roleId,
        "otpToken": otpToken,
      });
      final tokens = await remote.login(email, password);

      await secureStorageService.saveAccessToken(tokens["access_token"]);
      await secureStorageService.saveRefreshToken(tokens["refresh_token"]);
      return const Right(null);
    } catch (e) {
      return Left("Ro'yxatdan o'tishda xatolik");
    }
  }

  @override
  Future<Either<String, UserEntity>> getMe() async {
    try {
      final user = await remote.getMe();
      return Right(user);
    } catch (e) {
      return Left("Ma'lumotlarni olib bo'lmadi");
    }
  }

  @override
  Future<void> logout() async {
    await secureStorageService.clearAll();
  }
}
