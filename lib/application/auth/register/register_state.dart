import 'package:foodexpress_mobile/infrastructure/models/user/user_entity.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final UserEntity user;

  RegisterSuccess(this.user);
}

class RegisterFailure extends RegisterState {
  final String failure;

  RegisterFailure(this.failure);
}
