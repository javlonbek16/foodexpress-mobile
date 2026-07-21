abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String otpToken;

  RegisterButtonPressed({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.otpToken,
  });
}
