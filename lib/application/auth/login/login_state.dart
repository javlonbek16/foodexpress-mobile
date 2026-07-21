import 'package:foodexpress_mobile/infrastructure/models/user/user_entity.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserEntity user;

  LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  final String failure;

  LoginFailure(this.failure);
}
