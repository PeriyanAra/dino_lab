import 'package:loggy/loggy.dart';
import 'package:shared/src/logger/logger_dev.dart';
import 'package:shared/src/logger/logger_prod.dart';

/// With this logger instance you can access to logging features
/// Example: app_bloc.dart
/// ```dart
/// try {
///   throw Exception();
/// } on Object catch (e, st) {
///   l.presentation.error(e, stackTrace: st)
/// }
/// ```

abstract class Logger {
  /// Log only in presentation layer.
  Loggy get p;

  /// Log only in domain layer.
  Loggy get domain;

  /// Log only in data layer.
  Loggy get data;

  /// Log only in analytic layer.
  Loggy get analytic;

  // ignore: avoid_positional_boolean_parameters
  static Logger factory(bool isDev) {
    return isDev ? LoggerDev() : LoggerProd();
  }
}

/// Custom log levels for network logs.
extension LogLevelExtension on LogLevel {
  static const networkRequest = LogLevel('Request', 9);
  static const networkResponse = LogLevel('Response', 10);
  static const networkResponseError = LogLevel('Response error', 11);
}
