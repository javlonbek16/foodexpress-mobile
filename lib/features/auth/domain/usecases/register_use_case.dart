import 'package:foodexpress_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:foodexpress_mobile/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  Future<UserEntity> call(String name, String email, String password, int roleId, String otpToken) async {
    return await authRepository.register(name, email, password, roleId, otpToken);
  }
}
