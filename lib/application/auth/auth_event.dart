import 'package:foodexpress_mobile/infrastructure/models/user/user_entity.dart';

abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final UserEntity user;

  AuthLoggedIn(this.user);
}

class AuthLoggedOut extends AuthEvent {}
