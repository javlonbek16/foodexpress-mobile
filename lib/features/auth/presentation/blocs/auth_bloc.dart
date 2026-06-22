import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/features/auth/domain/usecases/login_use_case.dart';
import 'package:foodexpress_mobile/features/auth/domain/usecases/register_use_case.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_event.dart';
import 'package:foodexpress_mobile/features/auth/presentation/blocs/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthBloc({required this.loginUseCase, required this.registerUseCase}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        final user = await loginUseCase(event.email, event.password);

        emit(AuthSuccess(userEntity: user));
      } catch (e) {
        emit(AuthFailure(errorMessage: e.toString()));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        final user = await registerUseCase(
          event.name,
          event.email,
          event.password,
          event.roleId,
          event.otpToken,
        );

        emit(AuthSuccess(userEntity: user));
      } catch (e) {
        emit(AuthFailure(errorMessage: e.toString()));
      }
    });
  }
}
