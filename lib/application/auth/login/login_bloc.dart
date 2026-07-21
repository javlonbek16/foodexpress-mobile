import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/application/auth/login/login_event.dart';
import 'package:foodexpress_mobile/application/auth/login/login_state.dart';
import 'package:foodexpress_mobile/domain/use_cases/auth_use_cases.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthUseCases useCase;

  LoginBloc(this.useCase) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      final loginResult = await useCase.login(event.email, event.password);

      await loginResult.fold((error) async => emit(LoginFailure(error)), (_) async {
        final meResult = await useCase.getMe();
        meResult.fold((error) => emit(LoginFailure(error)), (user) => emit(LoginSuccess(user)));
      });
    });
  }
}
