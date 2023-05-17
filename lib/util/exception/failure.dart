import 'package:flutter/foundation.dart';

import '../../constant/network_constant.dart';
import '../helper/logger_helper.dart';
import '../service/service_locator.dart';

abstract class Failure implements Exception {
  late String message;
  late String failureType;
  final LoggerHelper _logger = locator<LoggerHelper>();
  final Object error;
  final StackTrace? stackTrace;

  Failure({required this.message, required this.failureType, required this.error, this.stackTrace}) {
    stackTrace ?? StackTrace.current;
    if (kDebugMode) _logError();
  }

  void _logError() {
    _logger.e('$failureType, $message', error, stackTrace);
  }

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  ServerFailure(String message, Object error, StackTrace? stack)
      : super(
          message: message,
          failureType: (ServerFailure).toString(),
          error: error,
          stackTrace: stack,
        );
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure(Object error, StackTrace? stack)
      : super(
          message: NetworkConstant.unauthorized,
          failureType: (UnauthorizedFailure).toString(),
          error: error,
          stackTrace: stack,
        );
}

class FormatFailure extends Failure {
  FormatFailure(Object error, StackTrace? stack)
      : super(
          message: NetworkConstant.formatException,
          failureType: (FormatFailure).toString(),
          error: error,
          stackTrace: stack,
        );
}

class ConnectionFailure extends Failure {
  ConnectionFailure(Object error, StackTrace? stack)
      : super(
          message: NetworkConstant.noConnection,
          failureType: (ConnectionFailure).toString(),
          error: error,
          stackTrace: stack,
        );
}

class UnhandledFailure extends Failure {
  UnhandledFailure(Object error, StackTrace? stack)
      : super(
          message: NetworkConstant.unhandledException,
          failureType: (UnhandledFailure).toString(),
          error: error,
          stackTrace: stack,
        );
}
