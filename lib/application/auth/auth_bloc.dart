import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/infrastructure/datasource/local/secure_storage_service.dart';
import 'package:foodexpress_mobile/domain/use_cases/auth_use_cases.dart';
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

      result.fold((error) async {
        await storage.clearAll();
        emit(Unauthenticated());
      }, (user) => emit(Authenticated(user)));
    });

    on<AuthLoggedIn>((event, emit) => emit(Authenticated(event.user)));

    on<AuthLoggedOut>((event, emit) async {
      await storage.clearAll();
      emit(Unauthenticated());
    });
  }
}
