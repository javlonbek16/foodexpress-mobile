abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email, password;
  LoginEvent(this.email, this.password);
}

class SendOtpEvent extends AuthEvent {
  final String email;
  SendOtpEvent(this.email);
}

class VerifyOtpEvent extends AuthEvent {
  final String email, code;
  VerifyOtpEvent(this.email, this.code);
}

class RegisterEvent extends AuthEvent {
  final String name, email, password, phone, otpToken;
  RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.otpToken,
  });
}
