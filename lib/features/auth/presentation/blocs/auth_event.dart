// part of "auth_bloc.dart";

abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final int roleId;
  final String otpToken;

  RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.roleId,
    required this.otpToken,
  });
}
