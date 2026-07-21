import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodexpress_mobile/application/auth/otp/otp_event.dart';
import 'package:foodexpress_mobile/application/auth/otp/otp_state.dart';
import 'package:foodexpress_mobile/domain/use_cases/auth_use_cases.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final AuthUseCases useCase;

  OtpBloc(this.useCase) : super(OtpInitial()) {
    on<SendOtpEvent>((event, emit) async {
      emit(OtpLoading());
      final result = await useCase.sendOtp(event.email);
      result.fold((error) => emit(OtpFailure(error)), (_) => OtpSentSuccess());
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(OtpLoading());
      final result = await useCase.verifyOtp(event.email, event.code);

      result.fold((error) => emit(OtpFailure(error)), (token) => OtpVerifiedSuccess(token));
    });
  }
}
