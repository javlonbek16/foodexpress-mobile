import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/core/local/secure_storage_service.dart';
import 'package:foodexpress_mobile/features/auth/domain/usecases/auth_use_cases.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCases useCases;
  final SecureStorageService storage;

  AuthBloc(this.useCases, this.storage) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      emit(AuthLoading());

      final token = await storage.getAccessToken();

      if (token == null) {
        emit(Unauthenticated());
        return;
      }

      final result = await useCases.getMe();

      if (result.isLeft()) {
        await storage.clearAll();
        emit(Unauthenticated());
      } else {
        emit(Authenticated(result.getOrElse(() => throw Exception())));
      }
    });
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      final loginResult = await useCases.login(event.email, event.password);

      if (loginResult.isLeft()) {
        emit(AuthError(loginResult.fold((l) => l, (r) => "")));
        return;
      }

      final meResult = await useCases.getMe();

      if (meResult.isLeft()) {
        emit(AuthError(meResult.fold((l) => l, (r) => "")));
        return;
      }

      emit(Authenticated(meResult.getOrElse(() => throw Exception())));
    });

    on<SendOtpEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await useCases.sendOtp(event.email);
      result.fold((error) => emit(AuthError(error)), (_) => emit(OtpSentState()));
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await useCases.verifyOtp(event.email, event.code);
      result.fold((error) => emit(AuthError(error)), (token) => emit(OtpVerifiedState(token)));
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await useCases.register(
        event.name,
        event.email,
        event.password,
        event.phone,
        3,
        event.otpToken,
      );

      await result.fold((error) async => emit(AuthError(error)), (_) async {
        final userResult = await useCases.getMe();
        userResult.fold((err) => emit(AuthError(err)), (user) => emit(Authenticated(user)));
      });
    });
  }
}
