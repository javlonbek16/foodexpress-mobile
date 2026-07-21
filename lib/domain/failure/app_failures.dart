abstract class AppFailures {
  final String message;

  const AppFailures(this.message);
}

class ServerFailure extends AppFailures {
  const ServerFailure(super.message);
}

class NoInternetFailure extends AppFailures {
  const NoInternetFailure(super.message);
}

class TimeoutFailure extends AppFailures {
  const TimeoutFailure(super.message);
}

class UnauthorizedFailure extends AppFailures {
  const UnauthorizedFailure(super.message);
}

class ValidationFailure extends AppFailures {
  const ValidationFailure(super.message);
}

class UnknownFailure extends AppFailures {
  const UnknownFailure(super.message);
}
