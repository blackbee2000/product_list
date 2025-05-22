abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class SystemFailure extends Failure {
  const SystemFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class DatabaseExecuteFailure extends Failure {
  const DatabaseExecuteFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}

class AccessDeniedFailure extends Failure {
  const AccessDeniedFailure(super.message);
}

class PlatformFailure extends Failure {
  final String code;
  const PlatformFailure(this.code, String message) : super(message);
}
