abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSentSuccess extends OtpState {}

class OtpVerifiedSuccess extends OtpState {
  final String otpToken;

  OtpVerifiedSuccess(this.otpToken);
}

class OtpFailure extends OtpState {
  final String failure;

  OtpFailure(this.failure);
}
