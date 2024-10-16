import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:loggy/loggy.dart';

/// Custom log levels for network logs.
extension LogLevelExtension on LogLevel {
  static const networkRequest = LogLevel('Request', 9);
  static const networkResponse = LogLevel('Response', 10);
  static const networkResponseError = LogLevel('Response error', 11);
}

abstract class _AnsiColors {
  static const red = '\x1b[0;31m';
  static const green = '\x1b[0;32m';
}

/// Custom printer in logger.
class DeveloperLogPrinter extends LoggyPrinter {
  /// Colorizes the logs in console.
  static const _logLevelColors = <LogLevel, String>{
    LogLevel.info: '\x1b[37m',
    LogLevel.warning: '\x1b[93m',
    LogLevel.debug: '\x1b[103m\x1b[31m',
    LogLevel.error: _AnsiColors.red,
    LogLevelExtension.networkRequest: '\x1b[12m',
    LogLevelExtension.networkResponse: _AnsiColors.green,
    LogLevelExtension.networkResponseError: _AnsiColors.red,
  };
  static const _endColor = '\x1b[0m';
  static const _defaultColor = '\x1b[90m';

  const DeveloperLogPrinter();

  @override
  void onLog(LogRecord record) {
    if (!kDebugMode) {
      return;
    }

    final startColor = _logLevelColors[record.level] ?? _defaultColor;

    log(
      '$startColor${record.level.name}: ${record.message}$_endColor',
      level: record.level.priority,
      name: record.loggerName,
      error: record.error,
      stackTrace: record.stackTrace,
      time: record.time,
      sequenceNumber: record.sequenceNumber,
      zone: record.zone,
    );
  }
}
