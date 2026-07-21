abstract class AppManagerState {}

class AppManagerInitial extends AppManagerState {}

class AppManagerLoading extends AppManagerState {}

class AppManagerError extends AppManagerState {
  final String error;

  AppManagerError(this.error);
}
