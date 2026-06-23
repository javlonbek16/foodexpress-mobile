import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodexpress_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:foodexpress_mobile/features/auth/data/models/login_model.dart';
import 'package:foodexpress_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:foodexpress_mobile/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final FlutterSecureStorage flutterSecureStorage;

  AuthRepositoryImpl({required this.authRemoteDataSource, required this.flutterSecureStorage});

  @override
  Future<UserEntity> login(String email, String password) async {
    final responseMap = await authRemoteDataSource.login(email, password);

    final loginModel = LoginModel.fromJson(responseMap);

    await flutterSecureStorage.write(key: "access_token", value: loginModel.accessToken);
    await flutterSecureStorage.write(key: "refresh_token", value: loginModel.refreshToken);

    return UserEntity(
      userId: loginModel.userId,
      role: loginModel.role,
      accessToken: loginModel.accessToken,
    );
  }

  @override
  Future<UserEntity> register(
    String name,
    String email,
    String password,
    int roleId,
    String otpToken,
  ) async {
    final responseMap = await authRemoteDataSource.register(
      name,
      email,
      password,
      roleId,
      otpToken,
    );

    final loginModel = LoginModel.fromJson(responseMap);

    await flutterSecureStorage.write(key: "access_token", value: loginModel.accessToken);
    await flutterSecureStorage.write(key: "refresh_token", value: loginModel.refreshToken);

    return UserEntity(
      userId: loginModel.userId,
      role: loginModel.role,
      accessToken: loginModel.accessToken,
    );
  }
}
