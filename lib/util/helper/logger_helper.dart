import 'package:logger/logger.dart';

class LoggerHelper {
  final Logger _logger;
  final Logger _loggerNoStack;

  LoggerHelper()
      : _logger = Logger(printer: PrettyPrinter()),
        _loggerNoStack = Logger(
          printer: PrettyPrinter(methodCount: 0, lineLength: 10),
        );

  void e(String message, dynamic e, StackTrace? stack) {
    _logger.e(message, e, stack);
  }

  void i(String message) {
    _loggerNoStack.i(message);
  }
}
