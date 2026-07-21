import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/application/auth/register/register_event.dart';
import 'package:foodexpress_mobile/application/auth/register/register_state.dart';
import 'package:foodexpress_mobile/domain/use_cases/auth_use_cases.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthUseCases useCase;

  RegisterBloc(this.useCase) : super(RegisterInitial()) {
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegisterLoading());
      final result = await useCase.register(event.name, event.email, event.password, event.phone, 3, event.otpToken);

      await result.fold((error) async => emit(RegisterFailure(error)), (_) async {
        final userResult = await useCase.getMe();
        userResult.fold((error) => emit(RegisterFailure(error)), (user) => emit(RegisterSuccess(user)));
      });
    });
  }
}
